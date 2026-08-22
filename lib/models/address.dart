class Address {
  final int? id; final String name,mobile,house,street,area,city,state,pincode; final bool isDefault;
  const Address({this.id,required this.name,required this.mobile,required this.house,required this.street,required this.area,required this.city,required this.state,required this.pincode,this.isDefault=false});
  factory Address.fromJson(Map<String,dynamic> j)=>Address(id:j['id'],name:j['fullName']??'',mobile:j['mobile']??'',house:j['house']??'',street:j['street']??'',area:j['area']??'',city:j['city']??'Hyderabad',state:j['state']??'Telangana',pincode:j['pincode']??'',isDefault:j['isDefault']??false);
  String get oneLine => '$house, $street, $area, $city - $pincode';
  Map<String,dynamic> toJson()=>{'fullName':name,'mobile':mobile,'house':house,'street':street,'area':area,'city':city,'state':state,'pincode':pincode,'isDefault':isDefault};
}
