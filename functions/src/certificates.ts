import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * 1. issueCertificate (Callable Function)
 * Issued by Club Admin, Faculty, or Super Admin.
 * Generates unique certNumber, verificationUrl, writes certificate and audit log atomically.
 */
export const issueCertificate = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated to issue certificates."
    );
  }

  const { studentId, eventId, achievementTitle } = data;
  const callerUid = context.auth.uid;

  // 1. Verify Issuer Permissions
  const callerDoc = await db.collection("users").doc(callerUid).get();
  const callerData = callerDoc.data();
  if (!callerData || !["clubAdmin", "faculty", "superAdmin"].includes(callerData.role)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Insufficient privileges to issue certificates."
    );
  }

  // 2. Fetch Student and Event Data
  const [studentDoc, eventDoc] = await Promise.all([
    db.collection("users").doc(studentId).get(),
    db.collection("events").doc(eventId).get(),
  ]);

  if (!studentDoc.exists || !eventDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Student or Event record missing.");
  }

  const student = studentDoc.data()!;
  const event = eventDoc.data()!;

  // 3. Generate Certificate Record
  const certificateId = `CERT_${eventId}_${studentId}`;
  const certNumber = `CERT-${new Date().getFullYear()}-${Math.floor(100000 + Math.random() * 900000)}`;
  const verificationUrl = `https://aiclubs-portal.web.app/verify/certificate/${certificateId}`;
  const pdfUrl = `https://storage.googleapis.com/aiclubs-portal.appspot.com/certificates/${certificateId}.pdf`;

  const certificatePayload = {
    id: certificateId,
    certificateNumber: certNumber,
    studentId: studentId,
    studentName: student.displayName ?? "Student",
    studentRollNo: student.studentRollNo ?? "N/A",
    eventId: eventId,
    eventTitle: event.title,
    clubId: event.clubId,
    clubName: event.clubName ?? "AI Technical Club",
    achievementTitle: achievementTitle ?? "Event Participation",
    issueDate: admin.firestore.FieldValue.serverTimestamp(),
    issuerUserId: callerUid,
    issuerName: callerData.displayName ?? "Authorized Issuer",
    issuerRole: callerData.role,
    status: "VALID",
    pdfUrl: pdfUrl,
    verificationUrl: verificationUrl,
  };

  const batch = db.batch();
  const certRef = db.collection("certificates").doc(certificateId);
  batch.set(certRef, certificatePayload, { merge: true });

  // 4. Record Audit Log
  const auditRef = db.collection("auditLogs").doc();
  batch.set(auditRef, {
    id: auditRef.id,
    performedByUserId: callerUid,
    action: "CERTIFICATE_ISSUED",
    targetCollection: "certificates",
    targetDocumentId: certificateId,
    metadata: { studentId, eventId, certNumber },
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });

  await batch.commit();
  return { success: true, certificateId, verificationUrl };
});

/**
 * 2. revokeCertificate (Callable Function)
 * Restricted to Faculty and Super Admins. Marks status as REVOKED with audit log.
 */
export const revokeCertificate = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Authentication required.");
  }

  const { certificateId, reason } = data;
  const callerUid = context.auth.uid;

  const callerDoc = await db.collection("users").doc(callerUid).get();
  const callerRole = callerDoc.data()?.role;

  if (!["faculty", "superAdmin"].includes(callerRole)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only Faculty and Super Admins can revoke certificates."
    );
  }

  const certRef = db.collection("certificates").doc(certificateId);
  const certDoc = await certRef.get();
  if (!certDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Certificate not found.");
  }

  const batch = db.batch();
  batch.update(certRef, {
    status: "REVOKED",
    revocationReason: reason ?? "Administrative Revocation",
    revokedAt: admin.firestore.FieldValue.serverTimestamp(),
    revokedByUserId: callerUid,
  });

  const auditRef = db.collection("auditLogs").doc();
  batch.set(auditRef, {
    id: auditRef.id,
    performedByUserId: callerUid,
    action: "CERTIFICATE_REVOKED",
    targetCollection: "certificates",
    targetDocumentId: certificateId,
    metadata: { reason },
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });

  await batch.commit();
  return { success: true };
});
