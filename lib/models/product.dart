enum DeliveryType { small, medium, large, heavy }

class Product {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final String brand;
  final String description;
  final List<String> images;
  final double mrp;
  final double sellingPrice;
  final String unit;
  final double? weight;
  final String? size;
  final Map<String, String> attributes;
  final bool isAvailable;
  final DeliveryType deliveryType;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.brand,
    required this.description,
    required this.images,
    required this.mrp,
    required this.sellingPrice,
    required this.unit,
    this.weight,
    this.size,
    this.attributes = const {},
    this.isAvailable = true,
    this.deliveryType = DeliveryType.small,
  });

  // Backward compatibility getters for existing code
  String get category => categoryName;
  String get image => images.isNotEmpty ? images.first : '📦';
  double get price => sellingPrice;

  double get discountPercent => mrp <= 0 ? 0 : ((mrp - sellingPrice) / mrp) * 100;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String? ?? 'general',
      categoryName: json['categoryName'] as String? ?? json['category'] as String? ?? 'General',
      brand: json['brand'] as String? ?? 'QuickCart',
      description: json['description'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [json['image']?.toString() ?? '📦'],
      mrp: (json['mrp'] as num?)?.toDouble() ?? 0.0,
      sellingPrice: (json['sellingPrice'] as num?)?.toDouble() ?? (json['price'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String? ?? '1 unit',
      weight: (json['weight'] as num?)?.toDouble(),
      size: json['size'] as String?,
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, v.toString())) ?? {},
      isAvailable: json['isAvailable'] as bool? ?? true,
      deliveryType: DeliveryType.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['deliveryType'] as String?)?.toLowerCase(),
        orElse: () => DeliveryType.small,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'brand': brand,
    'description': description,
    'images': images,
    'mrp': mrp,
    'sellingPrice': sellingPrice,
    'unit': unit,
    'weight': weight,
    'size': size,
    'attributes': attributes,
    'isAvailable': isAvailable,
    'deliveryType': deliveryType.name,
  };
}
