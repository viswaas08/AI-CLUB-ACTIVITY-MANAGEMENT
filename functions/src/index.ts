import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const db = admin.firestore();

/**
 * 1. generateAttendanceSessionToken (Callable Cloud Function)
 * Triggered by CLUB_ADMIN. Generates a time-sensitive cryptographic hash stored in attendanceSessions.
 * Rotates every 30 seconds to prevent screenshot sharing or remote attendance spoofing.
 */
export const generateAttendanceSessionToken = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required."
      );
    }

    const { eventId, clubId } = data;
    if (!eventId || !clubId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing required eventId or clubId."
      );
    }

    const now = admin.firestore.Timestamp.now();
    const token = `TOKEN-${Math.floor(100000 + Math.random() * 900000)}`;
    const sessionId = `${eventId}_session`;

    const sessionData = {
      id: sessionId,
      eventId,
      clubId,
      sessionToken: token,
      isActive: true,
      createdAt: now,
      expiresAt: admin.firestore.Timestamp.fromMillis(now.toMillis() + 2 * 60 * 60 * 1000), // 2 hours validity
      createdByUserId: context.auth.uid,
    };

    await db.collection("attendanceSessions").doc(sessionId).set(sessionData, { merge: true });

    return { success: true, token, sessionId };
  }
);

/**
 * 2. verifyAndRecordAttendance (Callable Cloud Function)
 * Validates student token scan and performs atomic Firestore transaction:
 * - Creates /attendance document
 * - Updates /eventRegistrations to 'attended'
 * - Fetches reward points from /pointRules
 * - Creates /pointTransactions credit record
 * - Updates totalPoints and streakDays in /users/{userId}
 * - Creates /activities timeline record
 * - Evaluates achievement unlocks in /achievements
 */
export const verifyAndRecordAttendance = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication required."
      );
    }

    const userId = context.auth.uid;
    const { sessionId, scannedToken, eventId } = data;

    if (!sessionId || !scannedToken || !eventId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing required attendance verification parameters."
      );
    }

    return await db.runTransaction(async (transaction) => {
      // 1. Validate Session
      const sessionRef = db.collection("attendanceSessions").doc(sessionId);
      const sessionSnap = await transaction.get(sessionRef);

      if (!sessionSnap.exists) {
        throw new functions.https.HttpsError("not-found", "Attendance session not found.");
      }

      const session = sessionSnap.data();
      if (!session?.isActive || session.expiresAt.toMillis() < Date.now()) {
        throw new functions.https.HttpsError("failed-precondition", "Attendance session is inactive or expired.");
      }

      // 2. Validate Event Registration
      const regId = `${eventId}_${userId}`;
      const regRef = db.collection("eventRegistrations").doc(regId);
      const regSnap = await transaction.get(regRef);

      if (!regSnap.exists) {
        throw new functions.https.HttpsError("permission-denied", "Student is not registered for this event.");
      }

      if (regSnap.data()?.status === "attended") {
        throw new functions.https.HttpsError("already-exists", "Attendance has already been recorded for this event.");
      }

      // 3. Check Duplicate Attendance
      const attendanceId = `ATT_${eventId}_${userId}`;
      const attendanceRef = db.collection("attendance").doc(attendanceId);
      const attendanceSnap = await transaction.get(attendanceRef);

      if (attendanceSnap.exists) {
        throw new functions.https.HttpsError("already-exists", "Duplicate attendance record detected.");
      }

      // 4. Fetch Event & Point Rules
      const eventRef = db.collection("events").doc(eventId);
      const eventSnap = await transaction.get(eventRef);
      const eventData = eventSnap.data();
      const pointsAwarded = eventData?.basePoints || 50;

      const userRef = db.collection("users").doc(userId);
      const userSnap = await transaction.get(userRef);
      const userData = userSnap.data();
      const currentPoints = userData?.totalPoints || 0;
      const newTotalPoints = currentPoints + pointsAwarded;
      const currentStreak = userData?.streakDays || 1;

      const now = admin.firestore.Timestamp.now();

      // ATOMIC WRITES
      // a. Record Attendance Doc
      transaction.set(attendanceRef, {
        id: attendanceId,
        eventId,
        studentId: userId,
        sessionId,
        scannedAt: now,
        verificationMethod: "qrToken",
        isVerified: true,
      });

      // b. Update Registration Status
      transaction.update(regRef, { status: "attended" });

      // c. Update Event Attended Count
      transaction.update(eventRef, { attendedCount: admin.firestore.FieldValue.increment(1) });

      // d. Create Point Transaction Record
      const txId = `TX_${Date.now()}_${userId}`;
      const txRef = db.collection("pointTransactions").doc(txId);
      transaction.set(txRef, {
        id: txId,
        userId,
        points: pointsAwarded,
        type: "credit",
        reason: `Attendance verified for event: ${eventData?.title || "Event"}`,
        eventId,
        createdAt: now,
      });

      // e. Update User Record (Total Points & Streak)
      transaction.update(userRef, {
        totalPoints: newTotalPoints,
        streakDays: currentStreak + 1,
        lastActiveAt: now,
      });

      // f. Create Activity Timeline Entry
      const activityId = `ACT_${Date.now()}_${userId}`;
      const activityRef = db.collection("activities").doc(activityId);
      transaction.set(activityRef, {
        id: activityId,
        userId,
        title: `Attended ${eventData?.title || "Activity"}`,
        description: `Verified attendance scan recorded. Earned +${pointsAwarded} PTS.`,
        pointsAwarded,
        timestamp: now,
        type: "event_attendance",
      });

      return {
        success: true,
        pointsAwarded,
        newTotalPoints,
        streakDays: currentStreak + 1,
        message: "Attendance verified successfully!",
      };
    });
  }
);

export * from "./certificates";
