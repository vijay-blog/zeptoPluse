import 'cart_item.dart';

enum OrderStatus {
  created,
  partnerSearching,
  partnerAssigned,
  partnerAccepted,
  picking,
  packed,
  deliverySearching,
  deliveryAssigned,
  pickedUp,
  outForDelivery,
  delivered,
  cancelled,
  outOfStock,
  deliveryFailed,
  returnRequested,
  returned,
}

extension OrderStatusText on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.created: return 'Order created';
      case OrderStatus.partnerSearching: return 'Finding nearby store partner';
      case OrderStatus.partnerAssigned: return 'Store partner assigned';
      case OrderStatus.partnerAccepted: return 'Store accepted order';
      case OrderStatus.picking: return 'Items being picked';
      case OrderStatus.packed: return 'Order packed & ready';
      case OrderStatus.deliverySearching: return 'Finding delivery partner';
      case OrderStatus.deliveryAssigned: return 'Delivery partner assigned';
      case OrderStatus.pickedUp: return 'Picked up by delivery partner';
      case OrderStatus.outForDelivery: return 'Out for delivery';
      case OrderStatus.delivered: return 'Delivered successfully';
      case OrderStatus.cancelled: return 'Order cancelled';
      case OrderStatus.outOfStock: return 'Item out of stock';
      case OrderStatus.deliveryFailed: return 'Delivery attempt failed';
      case OrderStatus.returnRequested: return 'Return requested';
      case OrderStatus.returned: return 'Returned';
    }
  }

  // For backward compatibility with existing code
  static OrderStatus fromLegacy(dynamic legacy) {
    if (legacy is OrderStatus) return legacy;
    return OrderStatus.created;
  }
}

class SubOrder {
  final String id;
  final String orderId;
  final String partnerId;
  final OrderStatus status;
  final String deliveryType;

  const SubOrder({
    required this.id,
    required this.orderId,
    required this.partnerId,
    required this.status,
    required this.deliveryType,
  });
}

class CustomerOrder {
  final String id;
  final String customerId;
  final DateTime createdAt;
  final List<CartItem> items;
  final String address;
  final double subtotal;
  final double deliveryFee;
  final double total;
  OrderStatus status;
  final List<SubOrder> subOrders;

  CustomerOrder({
    required this.id,
    this.customerId = 'guest_customer',
    required this.createdAt,
    required this.items,
    required this.address,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    this.status = OrderStatus.created,
    this.subOrders = const [],
  });
}
