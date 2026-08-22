# ZeptoPluse Customer App

Hyderabad-first hyperlocal marketplace customer application with Flutter + Spring Boot + MySQL.

## Scope
Customer shopping flow is implemented for browsing, search, categories, product details, cart, address, COD checkout, order history and order tracking.

## Run backend
1. Install Java 21 and Maven.
2. Make sure MySQL is running.
3. The default database is `zeptopluse`, user `root`, password `root`.
4. From `backend/` run:
   `mvn spring-boot:run`
5. Seed data is inserted on first startup.

Environment overrides:
- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`

## Run Flutter
Install Flutter 3.x, then from project root:

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api/v1
```

Android emulator uses `10.0.2.2` to reach the host machine. For a physical phone, use your computer's LAN IP, e.g. `http://192.168.1.10:8080/api/v1`.

The app falls back to bundled sample products if the backend is temporarily unavailable, so UI testing can continue.

## Production limitations
Authentication/OTP, Razorpay/UPI, partner routing, inventory by partner, delivery app, admin app, maps, push notifications, and production image CDN are intentionally future phases.

Medicine sales require applicable Indian legal and regulatory compliance before production use.
