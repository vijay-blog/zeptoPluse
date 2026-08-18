import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/product_card.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final list = products.where((p) => p.category == category).toList();
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .67,
          ),
          itemBuilder: (_, i) => ProductCard(product: list[i]),
        ),
      ),
    );
  }
}
