# QuickCart Customer App

Flutter MVP for a Hyderabad hyperlocal marketplace.

## Included
- Category browsing
- Product search
- Product details
- Cart
- Quantity controls
- Address entry
- COD checkout
- Order history
- Order status timeline
- Guest mode (authentication can be added later)
- Clean separation between UI, models and services

## Important
This MVP uses mock product/order data and local in-memory state. It is NOT connected to a real backend yet.

For production:
1. Connect `lib/services/api_service.dart` to the Spring Boot backend.
2. Add authentication/OTP.
3. Add persistent local storage.
4. Add real maps/location.
5. Add push notifications.
6. Add production error logging and analytics.
7. Configure Android/iOS signing and store metadata.

## Run
```bash
flutter pub get
flutter run
```

Open the project folder in Android Studio or VS Code.
