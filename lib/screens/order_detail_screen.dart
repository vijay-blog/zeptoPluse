import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderDetailScreen extends StatelessWidget {
  final CustomerOrder order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final active = [
      OrderStatus.placed,
      OrderStatus.partnerSearching,
      OrderStatus.partnerAssigned,
      OrderStatus.packing,
      OrderStatus.deliveryAssigned,
      OrderStatus.pickedUp,
      OrderStatus.outForDelivery,
      OrderStatus.delivered,
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Order ${order.id}')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Order status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),
                ...active.map((s) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    s.index <= order.status.index ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: s.index <= order.status.index ? Theme.of(context).colorScheme.primary : Colors.grey,
                  ),
                  title: Text(s.label),
                )),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                ...order.items.map((i) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(i.product.image, style: const TextStyle(fontSize: 28)),
                  title: Text(i.product.name),
                  subtitle: Text('${i.product.unit} × ${i.quantity}'),
                  trailing: Text('₹${i.total.toStringAsFixed(0)}'),
                )),
                const Divider(),
                Row(children: [
                  const Text('Total', style: TextStyle(fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Text('₹${order.total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800)),
                ]),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Delivery address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(order.address),
                const SizedBox(height: 12),
                const Row(children: [
                  Icon(Icons.payments_outlined),
                  SizedBox(width: 8),
                  Text('Cash on Delivery'),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
