class Product {
  final int id;
  final String name, category, brand, description, imageAsset, unit, deliveryType;
  final double mrp, sellingPrice;
  final int stock;
  final bool available;
  const Product({required this.id, required this.name, required this.category, required this.brand, required this.description, required this.imageAsset, required this.unit, required this.mrp, required this.sellingPrice, required this.stock, required this.available, required this.deliveryType});
  double get discount => mrp <= 0 ? 0 : ((mrp-sellingPrice)/mrp)*100;
  factory Product.fromJson(Map<String,dynamic> j) => Product(id: j['id'] ?? 0, name: j['name'] ?? '', category: j['categoryName'] ?? j['category'] ?? '', brand: j['brand'] ?? '', description: j['description'] ?? '', imageAsset: j['imageAsset'] ?? '', unit: j['unit'] ?? '1 unit', mrp: (j['mrp'] ?? 0).toDouble(), sellingPrice: (j['sellingPrice'] ?? 0).toDouble(), stock: j['stockQuantity'] ?? 0, available: j['available'] ?? true, deliveryType: j['deliveryType'] ?? 'SMALL');
}
