# QuickCart Customer App & Spring Boot Backend

QuickCart is a Hyderabad hyperlocal marketplace customer application built with **Flutter (Material 3)** and powered by a **Spring Boot 3 + MySQL** backend.

---

## Prerequisites
- Java 21 JDK
- Maven 3.x+
- Flutter SDK (>=3.4.0)
- MySQL Server (running locally on port 3306)

---

## MySQL Setup
Create the database in MySQL:
```sql
CREATE DATABASE quickcart CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
Verify credentials in `backend/src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/quickcart?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=root
```

---

## Starting the Spring Boot Backend
1. Open a terminal in `backend/`:
   ```bash
   cd backend
   mvn clean test
   mvn spring-boot:run
   ```
2. The database will automatically seed with categories and over 50 products on startup.
3. API will be available at `http://localhost:8080/api/v1`.

---

## Starting the Flutter Customer App
1. Open a terminal in the root project directory:
   ```bash
   flutter pub get
   flutter analyze
   flutter test
   ```
2. Run on Android Emulator or Device:
   ```bash
   flutter run
   ```
   *(By default, `AppConfig` uses `http://10.0.2.2:8080` for Android Emulator localhost. For physical devices, update `AppConfig.apiBaseUrl` in `customer_app/lib/core/app_config.dart` or `lib/core/app_config.dart` to your machine's local network IP).*

---

## Test Customer Flow
1. **Home Screen**: Browse Hyderabad location, search bar, category pills, and 50+ items.
2. **Categories**: View all items by category.
3. **Product Details**: Inspect specs, pricing, and add items to cart.
4. **Cart**: Review subtotal, delivery fee (Free for orders >= ₹499, else ₹39), and proceed to checkout.
5. **Address**: Add/select Hyderabad delivery address.
6. **Checkout & COD**: Place order via Cash on Delivery.
7. **Order Success & Tracking**: View order number, grand total, and full 14-state tracking timeline.
8. **My Orders**: Check order history and live status.

---

## Project Architecture
- **Backend (Modular Monolith)**:
  - `com.quickcart.controller`
  - `com.quickcart.service`
  - `com.quickcart.repository`
  - `com.quickcart.entity`
  - `com.quickcart.dto`
  - `com.quickcart.exception`
- **Frontend (Flutter Clean MVVM/Provider)**:
  - `lib/core/` (Config & API Client)
  - `lib/models/` (Data Entities)
  - `lib/services/` (REST Repositories)
  - `lib/providers/` (State Management)
  - `lib/screens/` (UI Screens)
