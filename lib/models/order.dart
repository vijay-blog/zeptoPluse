import 'cart_item.dart';
enum OrderStatus { created, partnerSearching, partnerAssigned, partnerAccepted, picking, packed, deliverySearching, deliveryAssigned, pickedUp, outForDelivery, delivered, cancelled }
extension OrderStatusX on OrderStatus { String get label => switch(this){OrderStatus.created=>'Order placed',OrderStatus.partnerSearching=>'Finding nearby store',OrderStatus.partnerAssigned=>'Store assigned',OrderStatus.partnerAccepted=>'Store accepted',OrderStatus.picking=>'Packing your order',OrderStatus.packed=>'Packed',OrderStatus.deliverySearching=>'Finding delivery partner',OrderStatus.deliveryAssigned=>'Delivery partner assigned',OrderStatus.pickedUp=>'Picked up',OrderStatus.outForDelivery=>'Out for delivery',OrderStatus.delivered=>'Delivered',OrderStatus.cancelled=>'Cancelled'}; }
class CustomerOrder {
 final String id; final DateTime createdAt; final List<CartItem> items; final double subtotal,deliveryFee,discount,total; final String address,paymentMethod; OrderStatus status;
 CustomerOrder({required this.id,required this.createdAt,required this.items,required this.subtotal,required this.deliveryFee,required this.discount,required this.total,required this.address,required this.paymentMethod,this.status=OrderStatus.created});
}
