# Implementation Plan — QuickCart Customer App Improvements

Improve the existing QuickCart Customer App MVP for the Hyderabad hyperlocal marketplace to meet all architecture, UI/UX, product model, and error-handling requirements without a full rewrite.

## User Review Required

> [!NOTE]
> - Retaining Provider for state management as requested and already implemented.
> - Upgrading the `Product` model to support multi-image lists, brand, weight/size, attributes, delivery type (`SMALL`, `MEDIUM`, `LARGE`, `HEAVY`), and `isAvailable`.
> - Aligning `CustomerOrder` status and UI with the full list of 16 statuses: `CREATED`, `PARTNER_SEARCHING`, `PARTNER_ASSIGNED`, `PARTNER_ACCEPTED`, `PICKING`, `PACKED`, `DELIVERY_SEARCHING`, `DELIVERY_ASSIGNED`, `PICKED_UP`, `OUT_FOR_DELIVERY`, `DELIVERED`, `CANCELLED`, `OUT_OF_STOCK`, `DELIVERY_FAILED`, `RETURN_REQUESTED`, `RETURNED`.
> - Introducing a repository/service abstraction (`ProductRepository`, `OrderRepository`, `AddressRepository`) ready for future Spring Boot REST API integration (`/api/v1/...`).

## Proposed Changes

### Models & Data Layer
#### [MODIFY] [product.dart](file:///C:/app/application/zeptoPlusegit/lib/models/product.dart)
- Update `Product` model with `brand`, `images` (List<String>), `weight`, `size`, `attributes` (Map<String, String>), `deliveryType` (small, medium, large, heavy), and `isAvailable`.

#### [MODIFY] [order.dart](file:///C:/app/application/zeptoPlusegit/lib/models/order.dart)
- Update `OrderStatus` enum to include all 16 requested statuses and friendly customer labels.
- Support sub-order / partner group placeholder architecture.

#### [NEW] [address.dart](file:///C:/app/application/zeptoPlusegit/lib/models/address.dart)
- Create `Address` model matching customer address fields (name, phone, house/flat, street, area, city, pincode).

#### [MODIFY] [mock_data.dart](file:///C:/app/application/zeptoPlusegit/lib/data/mock_data.dart)
- Expand categories and mock products across all required domains (Grocery, Vegetables, Fruits, Meat, Baby, Men, Women, Boys, Girls, Electronics, Laptops, TVs, ACs, Refrigerators, Furniture, Medicines, Home & Kitchen).

### Services & Repositories
#### [NEW] [repositories.dart](file:///C:/app/application/zeptoPlusegit/lib/services/repositories.dart)
- Define clean abstract interfaces (`ProductRepository`, `OrderRepository`, `AddressRepository`) and mock implementations (`MockProductRepository`, `MockOrderRepository`, `MockAddressRepository`) ready for Spring Boot REST integration.

### Screens & UI
#### [NEW] [product_detail_screen.dart](file:///C:/app/application/zeptoPlusegit/lib/screens/product_detail_screen.dart)
- Dedicated product details view with image gallery, pricing, MRP, discount badge, description, quantity selector, add to cart, and delivery estimate.

#### [MODIFY] [product_card.dart](file:///C:/app/application/zeptoPlusegit/lib/widgets/product_card.dart)
- Enhance product card with quick add, discount badge, rating/unit, and navigation to Product Detail Screen.

#### [MODIFY] [home_screen.dart](file:///C:/app/application/zeptoPlusegit/lib/screens/home_screen.dart)
- Add complete categories, featured products, search shortcut, and error/loading states.

#### [MODIFY] [cart_screen.dart](file:///C:/app/application/zeptoPlusegit/lib/screens/cart_screen.dart)
- Enhance cart management with clear empty state, subtotal, delivery calculation, and robust validation.

#### [MODIFY] [checkout_screen.dart](file:///C:/app/application/zeptoPlusegit/lib/screens/checkout_screen.dart)
- Add address validation, pincode validation, mobile number validation, and COD order creation.

#### [MODIFY] [orders_screen.dart](file:///C:/app/application/zeptoPlusegit/lib/screens/orders_screen.dart) & [order_detail_screen.dart](file:///C:/app/application/zeptoPlusegit/lib/screens/order_detail_screen.dart)
- Display friendly order status timeline and order items.

## Verification Plan

### Automated Tests
- Run `flutter analyze` and unit tests if any.
- Verify zero compilation errors.

### Manual Verification
- Review UI navigation across Home, Categories, Search, Product Details, Cart, Checkout, and Orders.
