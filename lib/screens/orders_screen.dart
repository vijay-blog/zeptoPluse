import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('My Orders', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          if (orders.isEmpty)
            const Expanded(child: Center(child: Text('No orders yet.')))
          else
            Expanded(
              child: ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final o = orders[i];
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      title: Text(o.id, style: const TextStyle(fontWeight: FontWeight.w800)),
                      subtitle: Text('${o.items.length} item(s) • ${o.status.label}'),
                      trailing: Text('₹${o.total.toStringAsFixed(0)}'),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(order: o))),
                    ),
                  );
                },
              ),
            ),
        ]),
      ),
    );
  }
}
