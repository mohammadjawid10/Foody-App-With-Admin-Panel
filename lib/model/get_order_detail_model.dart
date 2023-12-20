import 'order_item_detail_model.dart';

class GetOrderDetailModel {
  String status2='';
  String status='';
  String name='';
  String shipping='';
  String street='';
  String house='';
  String floor='';
  String address='';
  String address2='';
  String zip='';
  String city='';
  String phone='';
  String code='';
  String needAt='';
  String createdAt='';
  Items items=Items.empty();
  double subtotal=0.0;
  String orderNote='';
  String deliveryFee='';
  String orderGrandTotal='';
  String paymentType='';

  GetOrderDetailModel.empty();



  GetOrderDetailModel({required this.status2, required this.status, required this.name, required this.shipping, required this.street, required this.house, required this.floor, required this.address, required this.address2,required  this.zip, required this.city, required this.phone, required this.code,required  this.needAt, required this.createdAt, required this.items, required this.subtotal, required this.orderNote, required this.deliveryFee,required  this.orderGrandTotal});

  GetOrderDetailModel.fromJson(Map<String, dynamic> json) {
    status2 = json['status2']??'';
    status = json['status']??'';
    name = json['name']??'';
    shipping = json['shipping']??'';
    street = json['street']??'';
    house = json['house']??'';
    floor = json['floor']??'';
    address = json['address']??'';
    address2 = json['address_2']??'';
    zip = json['zip']??'';
    city = json['city']??'';
    phone = json['phone']??'';
    code = json['code']??'';
    needAt = json['need_at']??'';
    createdAt = json['created_at']??'';
    items = Items.fromJson(json['items']??{});
    subtotal = json['subtotal'] is int?json['subtotal'].toDouble():json['subtotal'] is String?double.parse(json['subtotal'].split('\u20ac')[0]):json['subtotal']??0.0;
    orderNote = json['ordernote']??'';
    deliveryFee = json['delivery_fee']??'';
    paymentType=json['payment_method']??'';
    orderGrandTotal = json['order_grand_total']??'';
  }

  @override
  String toString() {
    return 'GetOrderDetailModel{status2: $status2, status: $status, name: $name, shipping: $shipping, street: $street, house: $house, floor: $floor, address: $address, address2: $address2, zip: $zip, city: $city, phone: $phone, code: $code, needAt: $needAt, createdAt: $createdAt, items: $items, subtotal: $subtotal, orderNote: $orderNote, deliveryFee: $deliveryFee, orderGrandTotal: $orderGrandTotal}';
  }
}

class Items {
  List<OrderItemDetailModel> orderItemDetailModel=<OrderItemDetailModel>[];

  Items.empty();

  Items({required this.orderItemDetailModel});

  Items.fromJson(Map<String, dynamic> json) {
    List<dynamic> values = json.values.toList();
    for(int i=0;i<values.length;i++) {
      if (json['${i+1}'] != null) {
          orderItemDetailModel.add(OrderItemDetailModel.fromJson(json['${i+1}']));
      }

    }
  }

  @override
  String toString() {
    return 'Items{orderItemDetailModel: $orderItemDetailModel}';
  }
}


