import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/address.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'order_detail_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final name = TextEditingController(text: 'Raghupathi');
  final phone = TextEditingController(text: '9876543210');
  final house = TextEditingController(text: 'Flat 402, Sri Nilayam');
  final street = TextEditingController(text: 'Madhapur Main Road');
  final area = TextEditingController(text: 'Madhapur');
  final city = TextEditingController(text: 'Hyderabad');
  final pincode = TextEditingController(text: '500081');
  bool placing = false;

  @override
  void dispose() {
    name.dispose(); phone.dispose(); house.dispose(); street.dispose();
    area.dispose(); city.dispose(); pincode.dispose();
    super.dispose();
  }

  Future<void> placeOrder() async {
    if (name.text.trim().isEmpty || phone.text.trim().length < 10 ||
        house.text.trim().isEmpty || area.text.trim().isEmpty || pincode.text.trim().length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check your address details and valid 6-digit pincode.')),
      );
      return;
    }
    setState(() => placing = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final cart = context.read<CartProvider>();
    final address = Address(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      name: name.text.trim(),
      mobileNumber: phone.text.trim(),
      houseFlat: house.text.trim(),
      street: street.text.trim(),
      area: area.text.trim(),
      city: city.text.trim(),
      pincode: pincode.text.trim(),
    );

    final order = await context.read<OrderProvider>().createOrder(
      items: cart.items,
      address: address,
      total: cart.total,
    );
    cart.clear();
    if (!mounted) return;
    setState(() => placing = false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order)),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text('Delivery Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Customer Full Name')),
          const SizedBox(height: 10),
          TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Mobile Number')),
          const SizedBox(height: 10),
          TextField(controller: house, decoration: const InputDecoration(labelText: 'House / Flat / Apartment')),
          const SizedBox(height: 10),
          TextField(controller: street, decoration: const InputDecoration(labelText: 'Street / Road')),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: TextField(controller: area, decoration: const InputDecoration(labelText: 'Area / Locality'))),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: city, decoration: const InputDecoration(labelText: 'City'))),
            ],
          ),
          const SizedBox(height: 10),
          TextField(controller: pincode, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Pincode (Hyderabad 6 digits)')),
          const SizedBox(height: 22),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.payments_outlined, color: Colors.green),
                    title: Text('Cash on Delivery (COD)'),
                    subtitle: Text('Pay when your order arrives.'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          _summary(cart),
          const SizedBox(height: 18),
          SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: placing ? null : placeOrder,
              child: placing ? const CircularProgressIndicator(color: Colors.white) : Text('Place COD Order • ₹${cart.total.toStringAsFixed(0)}'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summary(CartProvider cart) => Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        _r('Items Subtotal', cart.subtotal),
        _r('Delivery Charge', cart.deliveryFee),
        const Divider(),
        _r('Grand Total', cart.total, bold: true),
      ]),
    ),
  );

  Widget _r(String label, double value, {bool bold = false}) => Row(
    children: [
      Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w800 : null)),
      const Spacer(),
      Text('₹${value.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.w800 : null)),
    ],
  );
}
