# 🌿 AI Club Activity Management & Student Analytics Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Hosting%20%7C%20Firestore%20%7C%20Auth-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions&logoColor=white)](.github/workflows/deploy.yml)

An enterprise-grade campus activities platform built with **Flutter Web**, **Firebase**, and **Riverpod**. Designed for universities and student clubs to automate real-time QR attendance, cryptographic certificate issuance & verification, predictive student drop-off analytics, proposal upvoting, and adaptive extracurricular engagement pathways.

---

## 🌟 Key Capabilities & Feature Matrix

### 🎓 1. Student Portal (`/student`)
- **Adaptive Skill Pathways**: Personalized step-by-step engagement paths recommending relevant club events and hands-on workshops based on student skill tags.
- **Civic Tech & Proposal Feeds**: Students can propose new campus initiatives, pitch workshop ideas, and upvote student-led proposals in real time.
- **Activity Radar & Gamification**: Real-time points tracking, streak status indicator, and campus-wide leaderboards.
- **Digital Activity Passport**: Verified record of club participations, badges, achievements, and cryptographic certificate downloads.

### 🏛️ 2. Club Leader Portal (`/club`)
- **Event Orchestration**: Create, manage, and publish technical workshops, hackathons, and guest lectures.
- **Dynamic QR Attendance Scanner**: Anti-fraud, rotating QR codes with cryptographic verification to eliminate proxy attendance.
- **Member Management**: Track active members, roles, attendance rates, and event RSVPs.
- **Automated Certificate Generation**: Issue verifiable digital certificates with SHA-256 signatures directly to participants' passports.

### 🔬 3. Faculty Advisor Portal (`/faculty`)
- **Department Activity Analytics**: Multi-club attendance trends, engagement heatmaps, and budget allocation oversight.
- **Proposal Approval Queue**: Review and sanction student proposals and club event funding requests.
- **Student Verification & Endorsements**: Faculty-level endorsement of student competencies and micro-credentials.

### 🛡️ 4. University Administrator Console (`/admin`)
- **Global Audit Logs**: Immutable audit trail tracking user role transitions, certificates issued, and administrative actions.
- **Gamification & Points Engine**: Configure campus-wide points calculation rules and tier thresholds.
- **Zero-Trust Role-Based Access Control (RBAC)**: Secure access enforcement for Super Admins, Faculty, Club Admins, and Students.

---

## 🎨 Mint Minimalist Design System

The platform features a **Mint Minimalist** light-mode design language with glassmorphism effects:

- **Background Canvas**: Crisp, cool off-white (`#F4F7F5`)
- **Borders & Dividers**: 1.0px hairline light gray-green (`#E2EAE5`)
- **Primary CTA & Status Indicator**: Energetic soft mint green (`#00A86B` / `#48BB78`)
- **Typography**: Clean `Inter` font hierarchy
  - Headings & Titles: Deep forest charcoal (`#1A2E22`)
  - Subtitles & Body Copy: Muted slate green (`#5A6E63`)
- **Geometry**: Standard 8px rounded corners (`BorderRadius.circular(8.0)`) across all cards, containers, buttons, and badges.
- **Glassmorphism**: Hardware-accelerated `BackdropFilter` frosted blur (`sigma: 16.0`), specular highlight borders, and translucent surface overlays.

---

## 🏗️ Architecture & Technology Stack

```
lib/
├── backend/                  # Firebase Core, Providers, Options, & Emulator Config
├── core/
│   ├── config/               # Compile-time environment constants (EnvConfig)
│   ├── responsive/           # Adaptive desktop / tablet / mobile breakpoints
│   ├── router/               # GoRouter with authentication & RBAC guards
│   └── theme/                # Mint Minimalist Organic & Skeuomorphic Themes
├── features/
│   ├── admin/                # SuperAdmin analytics, point rules, & audit logging
│   ├── auth/                 # Multi-role authentication & instant demo credentials
│   ├── certificates/         # Cryptographic certificate verification & issuance
│   ├── club/                 # Club lead management, dynamic QR, & event ops
│   ├── faculty/              # Faculty advisor dashboards & verification queues
│   ├── landing/              # Interactive hero landing screen with particle canvas
│   ├── proposals/            # Civic tech proposal upvoting & ranking engine
│   └── student/              # Student dashboard, adaptive pathways, & activity passport
└── shared/
    └── widgets/              # Reusable glassmorphic buttons, cards, inputs, and navbars
```

---

## ⚡ Instant Demo Access

The authentication portal comes pre-configured with **1-Click Demo Logins** for all roles:

| Role | Demo Account | Destination Dashboard |
| :--- | :--- | :--- |
| **Student** | `student@university.edu` | `/student` |
| **Club Leader** | `leader@university.edu` | `/club` |
| **Faculty Advisor** | `faculty@university.edu` | `/faculty` |
| **Super Admin** | `admin@university.edu` | `/admin` |

---

## 🚀 Local Development Setup

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`v3.22+`)
- [Firebase CLI](https://firebase.google.com/docs/cli) (`npm install -g firebase-tools`)
- Python 3 (optional, for local static serving)

### Installation
```bash
# 1. Clone the repository
git clone https://github.com/viswaas08/AI-CLUB-ACTIVITY-MANAGEMENT.git
cd AI-CLUB-ACTIVITY-MANAGEMENT

# 2. Install Flutter dependencies
flutter pub get

# 3. Analyze codebase for quality
flutter analyze

# 4. Run locally on Chrome / Web
flutter run -d chrome

# 5. Build for production web
flutter build web --release
```

---

## ☁️ Continuous Deployment with Firebase Hosting

This repository is equipped with GitHub Actions (`.github/workflows/deploy.yml`) for automated CI/CD deployment to Firebase Hosting on every push to `main`.

### To connect your Firebase project:
1. In your GitHub repository, go to **Settings > Secrets and variables > Actions**.
2. Add the repository secret:
   - **`FIREBASE_SERVICE_ACCOUNT_AI_CLUB_ACTIVITY`**: Service account JSON key generated from [Firebase Console Service Accounts](https://console.firebase.google.com/u/0/project/ai-club-activity/settings/serviceaccounts/adminsdk).
3. Any merge to `main` will automatically build the Flutter Web release and deploy live to:
   - `https://ai-club-activity.web.app`
   - `https://ai-club-activity.firebaseapp.com`

---

## 📄 License
This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
