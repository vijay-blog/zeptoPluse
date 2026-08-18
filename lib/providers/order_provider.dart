import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final List<CustomerOrder> _orders = [];

  List<CustomerOrder> get orders => List.unmodifiable(_orders);

  CustomerOrder createOrder({
    required List<CartItem> items,
    required String address,
    required double total,
  }) {
    final order = CustomerOrder(
      id: 'QC${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
      createdAt: DateTime.now(),
      items: items.map((e) => CartItem(product: e.product, quantity: e.quantity)).toList(),
      address: address,
      total: total,
    );
    _orders.insert(0, order);
    notifyListeners();
    return order;
  }
}
