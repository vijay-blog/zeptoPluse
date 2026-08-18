import '../models/product.dart';
import '../models/order.dart';
import '../models/address.dart';
import '../data/mock_data.dart';
import '../models/cart_item.dart';

abstract class ProductRepository {
  Future<List<CategoryItem>> getCategories();
  Future<List<Product>> getProducts({int page = 1, int pageSize = 20, String? search, String? categoryId, String? sort});
  Future<Product?> getProductById(String id);
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> searchProducts(String query);
}

abstract class OrderRepository {
  Future<CustomerOrder> createOrder({required List<CartItem> items, required Address address, required double total});
  Future<List<CustomerOrder>> getOrders();
  Future<CustomerOrder?> getOrderById(String orderId);
}

abstract class AddressRepository {
  Future<List<Address>> getAddresses();
  Future<Address> saveAddress(Address address);
  Future<void> deleteAddress(String id);
}

// Mock Implementation ready for future Spring Boot REST API
class MockProductRepository implements ProductRepository {
  @override
  Future<List<CategoryItem>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return categories.map((e) => CategoryItem(name: e.$1, icon: e.$2)).toList();
  }

  @override
  Future<List<Product>> getProducts({int page = 1, int pageSize = 20, String? search, String? categoryId, String? sort}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    var list = products;
    if (categoryId != null && categoryId.isNotEmpty) {
      list = list.where((p) => p.categoryId.toLowerCase() == categoryId.toLowerCase() || p.categoryName.toLowerCase() == categoryId.toLowerCase()).toList();
    }
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q) || p.categoryName.toLowerCase().contains(q) || p.brand.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  @override
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    return getProducts(categoryId: categoryId);
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    return getProducts(search: query);
  }
}

class CategoryItem {
  final String name;
  final String icon;
  const CategoryItem({required this.name, required this.icon});
}

class MockOrderRepository implements OrderRepository {
  final List<CustomerOrder> _orders = [];

  @override
  Future<CustomerOrder> createOrder({required List<CartItem> items, required Address address, required double total}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final subtotal = items.fold(0.0, (sum, i) => sum + i.total);
    final deliveryFee = subtotal >= 499 ? 0.0 : 39.0;
    final order = CustomerOrder(
      id: 'QC${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
      createdAt: DateTime.now(),
      items: items.map((e) => CartItem(product: e.product, quantity: e.quantity)).toList(),
      address: address.fullAddress,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: subtotal + deliveryFee,
      status: OrderStatus.created,
      subOrders: [
        SubOrder(
          id: 'SO-${DateTime.now().millisecondsSinceEpoch}',
          orderId: 'QC${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
          partnerId: 'PARTNER_HYD_01',
          status: OrderStatus.created,
          deliveryType: 'SMALL',
        ),
      ],
    );
    _orders.insert(0, order);
    return order;
  }

  @override
  Future<List<CustomerOrder>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_orders);
  }

  @override
  Future<CustomerOrder?> getOrderById(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (_) {
      return null;
    }
  }
}

class MockAddressRepository implements AddressRepository {
  final List<Address> _addresses = [
    const Address(
      id: 'addr_1',
      name: 'Raghupathi',
      mobileNumber: '9876543210',
      houseFlat: 'Flat 402, Sri Nilayam',
      street: 'Madhapur Main Road',
      area: 'Madhapur',
      city: 'Hyderabad',
      pincode: '500081',
      isDefault: true,
    ),
  ];

  @override
  Future<List<Address>> getAddresses() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_addresses);
  }

  @override
  Future<Address> saveAddress(Address address) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _addresses.add(address);
    return address;
  }

  @override
  Future<void> deleteAddress(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _addresses.removeWhere((a) => a.id == id);
  }
}
