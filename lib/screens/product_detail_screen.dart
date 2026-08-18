import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final cartItem = cart.items.firstWhere(
      (i) => i.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(product.categoryName),
        actions: [
          Badge(
            isLabelVisible: cart.itemCount > 0,
            label: Text('${cart.itemCount}'),
            child: IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 240,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(product.image, style: const TextStyle(fontSize: 88)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(product.brand, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              if (!product.isAvailable)
                const Text('Currently Unavailable', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
              else
                const Text('⚡ 10 mins delivery in Hyderabad', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('${product.unit}${product.weight != null ? ' • ${product.weight}kg' : ''}', style: const TextStyle(color: Colors.grey, fontSize: 15)),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('₹${product.sellingPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              const SizedBox(width: 12),
              if (product.mrp > product.sellingPrice) ...[
                Text('₹${product.mrp.toStringAsFixed(0)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 16)),
                const SizedBox(width: 10),
                Text('${product.discountPercent.toStringAsFixed(0)}% OFF', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          const Text('Product details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(product.description, style: const TextStyle(color: Colors.black87, height: 1.4)),
          if (product.attributes.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text('Specifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            ...product.attributes.entries.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(e.key, style: const TextStyle(color: Colors.grey)),
                  const Spacer(),
                  Text(e.value, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            )),
          ],
          const SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))]),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('₹${product.sellingPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              ],
            ),
            const Spacer(),
            if (cartItem.quantity == 0)
              SizedBox(
                width: 180,
                height: 48,
                child: FilledButton.icon(
                  onPressed: product.isAvailable ? () => context.read<CartProvider>().add(product) : null,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Add to Cart'),
                ),
              )
            else
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => context.read<CartProvider>().decrement(product),
                    icon: const Icon(Icons.remove),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('${cartItem.quantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filled(
                    onPressed: () => context.read<CartProvider>().increment(product),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
