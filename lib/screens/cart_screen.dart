import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.items.isEmpty
        ? const Center(child: Text('Your cart is empty'))
        : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 24),
                  itemBuilder: (_, i) {
                    final item = cart.items[i];
                    return Row(
                      children: [
                        Container(
                          width: 58, height: 58,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: const Color(0xFFF0F3F1), borderRadius: BorderRadius.circular(12)),
                          child: Text(item.product.image, style: const TextStyle(fontSize: 28)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w700)),
                            Text('₹${item.product.price.toStringAsFixed(0)} × ${item.quantity}'),
                          ],
                        )),
                        IconButton(onPressed: () => cart.decrement(item.product), icon: const Icon(Icons.remove_circle_outline)),
                        Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(onPressed: () => cart.increment(item.product), icon: const Icon(Icons.add_circle_outline)),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    _row('Subtotal', cart.subtotal),
                    _row('Delivery', cart.deliveryFee),
                    const Divider(),
                    _row('Total', cart.total, bold: true),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                        child: Text('Continue • ₹${cart.total.toStringAsFixed(0)}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) => Row(
    children: [
      Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.normal)),
      const Spacer(),
      Text('₹${value.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.normal)),
    ],
  );
}
