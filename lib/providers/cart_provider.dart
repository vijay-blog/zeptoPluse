import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);
  double get deliveryFee => subtotal == 0 ? 0 : (subtotal >= 499 ? 0 : 39);
  double get total => subtotal + deliveryFee;

  void add(Product product) {
    final index = _items.indexWhere((x) => x.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product: product));
    } else {
      _items[index].quantity++;
    }
    notifyListeners();
  }

  void increment(Product product) {
    add(product);
  }

  void decrement(Product product) {
    final index = _items.indexWhere((x) => x.product.id == product.id);
    if (index == -1) return;
    if (_items[index].quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index].quantity--;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
