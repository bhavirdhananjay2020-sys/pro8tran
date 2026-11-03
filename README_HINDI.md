# ROUTEX89 Android MVP — Hindi Guide

**Brand:** ROUTEX89 | **Tagline:** Moving India Forward.  
**Colours:** Navy `#101F3B`, Orange `#F28C28`, White `#FFFFFF`

## Included
- Flutter Android starter
- Dashboard, demo load posting, own/market fleet list and business placeholders
- GitHub Actions debug APK workflow
- Product blueprint and brand guide

## Important
This is a **prototype**, not production software. Demo data is stored in memory and resets after app restart. Real OTP, backend sync, KYC, GPS, payment gateway, GST/LR documents, bank payouts and production security are not connected. Do not enter real PAN, Aadhaar, licence, bank or customer-sensitive data.

## Build locally
```bash
flutter pub get
flutter analyze
flutter run
```

## GitHub upload
1. Open your private `pro8tran-mvp` repository.
2. Check its current files first. Do not delete/overwrite existing files without a backup.
3. Extract this ZIP and upload the contents of the extracted folder to the repository root (`pubspec.yaml` must be at root).
4. Commit with message: `ROUTEX89 Android MVP v0.1`.
5. Open Actions and check `Build ROUTEX89 Android APK`.
6. After a successful run, download `ROUTEX89-Android-APK` from Artifacts.

## Next build milestones
1. Role-based login + Supabase Auth/PostgreSQL.
2. Customer, broker, transporter and driver permissions.
3. Booking, offer, assignment and trip workflow.
4. LR/POD, ledger and settlements.
5. Consent-based GPS and approved payment integration.
6. Security testing, privacy/legal review and Play Store readiness.

Do not publish this prototype as a production app.
