
import 'cart_item_model.dart';

class GetCartModel {
  List<CartItemModel> items=[];
  double totalPurchase=0.0;
  String deliveryFee='';
  String minimumOrder='';
  double cartTotalAmount=0.0;
  int cartTotalQty=0;
  String type='';
  String message='';

  GetCartModel.empty();

  GetCartModel(
      {required this.items,
        required this.message,
        required this.type,
        required this.totalPurchase,
        required this.deliveryFee,
        required this.minimumOrder,
        required this.cartTotalAmount,
        required this.cartTotalQty});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CartItemModel>[];
      json['items'].forEach((v) {
        items.add(CartItemModel.fromJson(v));
      });
    }
    totalPurchase = json['totalpurchase']is int ?json['totalpurchase'].toDouble():json['totalpurchase']??0.0;
    deliveryFee = json['delivery_fee'].toString()??'';
    minimumOrder = json['minimum_order']??'';
    type = json['type']??'';
    message = json['msg']??'';
    cartTotalAmount = json['carttotalamount'] is int ?json['carttotalamount'].toDouble():json['carttotalamount'] ??0.0;
    cartTotalQty = json['carttotalqty']??0;
  }

  @override
  String toString() {
    return 'GetCartModel{items: $items, totalPurchase: $totalPurchase, deliveryFee: $deliveryFee, minimumOrder: $minimumOrder, cartTotalAmount: $cartTotalAmount, cartTotalQty: $cartTotalQty, type: $type, message: $message}';
  }
}


