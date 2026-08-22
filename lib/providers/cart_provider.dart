import 'package:flutter/foundation.dart';
import '../models/cart_item.dart'; import '../models/product.dart';
class CartProvider extends ChangeNotifier {final List<CartItem> items=[]; int get count=>items.fold(0,(a,b)=>a+b.quantity); double get subtotal=>items.fold(0,(a,b)=>a+b.total); double get delivery=>subtotal==0?0:(subtotal>=499?0:39); double get total=>subtotal+delivery;
 void add(Product p){final i=items.indexWhere((x)=>x.product.id==p.id);if(i<0)items.add(CartItem(product:p));else items[i].quantity++;notifyListeners();}
 void remove(Product p){final i=items.indexWhere((x)=>x.product.id==p.id);if(i<0)return;if(items[i].quantity<=1)items.removeAt(i);else items[i].quantity--;notifyListeners();}
 void delete(Product p){items.removeWhere((x)=>x.product.id==p.id);notifyListeners();} void clear(){items.clear();notifyListeners();}
}
