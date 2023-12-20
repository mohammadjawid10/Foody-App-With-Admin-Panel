class OrderItemDetailModel{
  int sr=0;
  String name='';
  String code='';
  String image='';
  String variationName='';
  List<Addons> addons=[];
  List<Addons> multiAddons=[];
  String note='';
  String amount='';
  String itemTotal='';

  OrderItemDetailModel.empty();

  OrderItemDetailModel({required this.sr, required this.name, required this.code, required this.image, required this.variationName, required this.addons, required this.note, required this.amount, required this.itemTotal});

  OrderItemDetailModel.fromJson(Map<String, dynamic> json) {
    sr = json['sr']??0;
    name = json['name']??'';
    code = json['code']??'';
    image = json['image']??'';
    variationName = json['variationname']??'';
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) { addons.add(Addons.fromJson(v)); });
    }
    if (json['multiaddons'] != null) {
      multiAddons = <Addons>[];
      json['multiaddons'].forEach((v) { addons.add(Addons.fromJson(v)); });
    }
    note = json['note']??'';
    amount = json['amount']??'';
    itemTotal = json['itemtotal']??'';
  }

  @override
  String toString() {
    return 'OrderItemDetailModel{sr: $sr, name: $name, code: $code, image: $image, variationName: $variationName, addons: $addons, note: $note, amount: $amount, itemTotal: $itemTotal}';
  }
}

class Addons {
  String name='';
  String description='';
  String amount='0';

  Addons({required this.name, required this.description, required this.amount});

  Addons.fromJson(Map<String, dynamic> json) {
    name = json['name']??'';
    description = json['description']??'';
    amount = json['amount'].toString();
  }

  @override
  String toString() {
    return 'Addons{name: $name, description: $description, amount: $amount}';
  }
}