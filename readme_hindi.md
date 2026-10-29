# Pro8Tran MVP Starter — आसान गाइड

यह SwifPace X Logistics Pvt Ltd के Pro8Tran ऐप का शुरुआती Flutter demo code है। इसमें Customer booking, Truck Partner registration और Admin dashboard की basic screens हैं।

## बहुत जरूरी बात
- यह **demo/starter code** है, production-ready transport business app नहीं।
- इसमें असली login/OTP, cloud database, GST invoice integration, live GPS, KYC verification, payment gateway या bank settlement नहीं है।
- डेटा केवल app चलने तक memory में रहता है और app बंद होने पर मिट जाता है।
- इसमें असली PAN, Aadhaar, licence, bank account या customer data न डालें।
- 90% advance और POD के बाद balance भुगतान को production में लगाने से पहले payment provider, CA और legal adviser से settlement structure approve करवाएं।

## इसे चलाने के लिए क्या चाहिए?
1. Computer/laptop (Windows, Mac या Linux).
2. Flutter SDK और Android Studio install करें: https://docs.flutter.dev/get-started/install
3. ZIP extract करें.
4. Terminal/Command Prompt में इस folder में जाएं.
5. ये commands चलाएं:

```bash
flutter pub get
flutter run
```

Android phone पर चलाने के लिए phone में Developer Options और USB debugging enable करके USB से connect करें, या Android emulator चलाएं.

## App में अभी क्या है?
- Home screen: Customer, Truck Partner और Admin के options
- Customer: pickup, delivery, vehicle type, freight और payment preference की demo booking
- Truck Partner: owner, phone, vehicle, registration, driver और bank account holder name की demo entry
- Admin: demo bookings और partners की list
- आपके बताए गए pickup/container/open truck categories

## Production launch से पहले जरूरी काम
- Secure phone OTP authentication and user roles
- Backend API and database (e.g. PostgreSQL)
- Private document upload and KYC verification workflow
- GST-compliant invoicing and CA-reviewed tax rules
- GPS provider integration and driver consent
- Approved payment provider integration, refunds, reconciliation and settlement controls
- POD hard-copy verification and balance release workflow
- Audit logs, backups, privacy policy, terms, security testing and production hosting

## Folder structure
- `lib/main.dart` — starter app screens
- `pubspec.yaml` — Flutter dependencies

किसी developer को यह ZIP देकर कहें कि पहले demo run कराए, फिर production backend और integrations को अलग milestones में estimate करे। पूरा payment एक साथ देने के बजाय source-code ownership, milestones, testing और handover लिखित contract में रखें।
