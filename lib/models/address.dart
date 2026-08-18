class Address {
  final String id;
  final String name;
  final String mobileNumber;
  final String houseFlat;
  final String street;
  final String area;
  final String city;
  final String pincode;
  final bool isDefault;

  const Address({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.houseFlat,
    required this.street,
    required this.area,
    required this.city,
    required this.pincode,
    this.isDefault = false,
  });

  String get fullAddress => '$houseFlat, $street, $area, $city - $pincode';

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json['id'] as String,
    name: json['name'] as String,
    mobileNumber: json['mobileNumber'] as String,
    houseFlat: json['houseFlat'] as String,
    street: json['street'] as String,
    area: json['area'] as String,
    city: json['city'] as String,
    pincode: json['pincode'] as String,
    isDefault: json['isDefault'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'mobileNumber': mobileNumber,
    'houseFlat': houseFlat,
    'street': street,
    'area': area,
    'city': city,
    'pincode': pincode,
    'isDefault': isDefault,
  };
}
