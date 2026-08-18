import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quickcart_customer/core/api_client.dart';
import 'package:quickcart_customer/core/app_config.dart';
import 'package:quickcart_customer/services/rest_repositories.dart';
import 'package:quickcart_customer/models/product.dart';
import 'package:quickcart_customer/models/address.dart';
import 'package:quickcart_customer/models/cart_item.dart';
import 'package:quickcart_customer/models/order.dart';

void main() {
  group('ApiClient and Error Handling Tests', () {
    test('handles 200 OK successful response', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode([{'id': '1', 'name': 'Test Product'}]), 200);
      });

      final apiClient = ApiClient(client: mockClient);
      final result = await apiClient.request(HttpMethod.get, '/api/v1/products');

      expect(result, isA<List>());
      expect((result as List).first['name'], 'Test Product');
    });

    test('throws ApiException on 400 Bad Request', () async {
      final mockClient = MockClient((request) async {
        return http.Response(jsonEncode({'message': 'Invalid parameters'}), 400);
      });

      final apiClient = ApiClient(client: mockClient);
      expect(
        () => apiClient.request(HttpMethod.get, '/api/v1/products'),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 'statusCode', 400)),
      );
    });

    test('throws ApiException on 401 Unauthorized', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Unauthorized', 401);
      });

      final apiClient = ApiClient(client: mockClient);
      expect(
        () => apiClient.request(HttpMethod.get, '/api/v1/orders'),
        throwsA(isA<ApiException>().having((e) => e.message, 'message', contains('Unauthorized'))),
      );
    });

    test('throws ApiException on 500 Server Error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      final apiClient = ApiClient(client: mockClient);
      expect(
        () => apiClient.request(HttpMethod.get, '/api/v1/orders'),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 'statusCode', 500)),
      );
    });
  });

  group('RestProductRepository Tests', () {
    test('fetches categories successfully', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/api/v1/categories');
        return http.Response(jsonEncode([
          {'name': 'Grocery', 'icon': '🛒'}
        ]), 200);
      });

      final repo = RestProductRepository(apiClient: ApiClient(client: mockClient));
      final categories = await repo.getCategories();

      expect(categories.length, 1);
      expect(categories.first.name, 'Grocery');
    });
  });

  group('RestOrderRepository & Request Mapping Tests', () {
    test('creates order with correct payload structure', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/api/v1/orders');
        final body = jsonDecode(request.body);
        expect(body['paymentMethod'], 'COD');
        expect(body['items'], isA<List>());
        expect(body['items'][0]['productId'], 'p1');

        return http.Response(jsonEncode({
          'id': 'QC9999',
          'customerId': 'guest',
          'createdAt': DateTime.now().toIso8601String(),
          'address': 'Test Address, Hyderabad',
          'subtotal': 499.0,
          'deliveryFee': 0.0,
          'total': 499.0,
          'status': 'created',
        }), 200);
      });

      final repo = RestOrderRepository(apiClient: ApiClient(client: mockClient));
      const product = Product(
        id: 'p1',
        name: 'Rice',
        categoryId: 'grocery',
        categoryName: 'Grocery',
        brand: 'India Gate',
        description: 'Basmati',
        images: ['🍚'],
        mrp: 599,
        sellingPrice: 499,
        unit: '5 kg',
      );

      const address = Address(
        id: 'a1',
        name: 'Raghupathi',
        mobileNumber: '9876543210',
        houseFlat: 'Flat 402',
        street: 'Main Road',
        area: 'Madhapur',
        city: 'Hyderabad',
        pincode: '500081',
      );

      final order = await repo.createOrder(
        items: [CartItem(product: product, quantity: 1)],
        address: address,
        total: 499,
      );

      expect(order.id, 'QC9999');
      expect(order.total, 499.0);
    });
  });

  group('RestAddressRepository Tests', () {
    test('fetches addresses successfully', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/api/v1/addresses');
        return http.Response(jsonEncode([
          {
            'id': 'a1',
            'name': 'Raghupathi',
            'mobileNumber': '9876543210',
            'houseFlat': 'Flat 402',
            'street': 'Street',
            'area': 'Area',
            'city': 'Hyderabad',
            'pincode': '500081',
            'isDefault': true,
          }
        ]), 200);
      });

      final repo = RestAddressRepository(apiClient: ApiClient(client: mockClient));
      final addresses = await repo.getAddresses();

      expect(addresses.length, 1);
      expect(addresses.first.pincode, '500081');
    });
  });
}
