import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:liefermars/model/single_addons_model.dart';

import 'cart_option_model.dart';
import 'multi_addons_model.dart';

class CartItemModel {
  String name='';
  String code='';
  String temp='';
  RxString quantity=''.obs;
  String note='';
  String price='';
  List<MultiAddonsModel> multiAddonsList=[];
  List<SingleAddonsModel> singleAddonsList=[];
  CartOptionModel optionModel=CartOptionModel.empty();
  double itemPrice=0.0;

  CartItemModel.empty();

  CartItemModel(
      {required this.name,
        required this.code,
        required this.temp,
        required this.quantity,
        required this.note,
        required this.price,
        required this.multiAddonsList,
        required this.singleAddonsList,
        required this.optionModel,
        required this.itemPrice});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name']??'';
    code = json['code']??'';
    temp = json['temp']??'';
    quantity.value = json['quantity']??'';
    note = json['note']??'';
    price = json['price']??'';
    if (json['multiaddonsarr'] != null) {
      multiAddonsList = <MultiAddonsModel>[];
      json['multiaddonsarr'].forEach((v) {
        multiAddonsList.add(MultiAddonsModel.fromJson(v));
      });
    }
    if (json['addonarr'] != null) {
      singleAddonsList = <SingleAddonsModel>[];
      json['addonarr'].forEach((v) {
        singleAddonsList.add(SingleAddonsModel.fromJson(v));
      });
    }
    optionModel =CartOptionModel.fromJson(json['optionarr']??{});
    itemPrice = json['itemprice'] is int ?json['itemprice'].toDouble():json['itemprice']??0.0;
  }

  @override
  String toString() {
    return 'CartItemModel{name: $name, code: $code, temp: $temp, quantity: $quantity, note: $note, price: $price, multiAddonsList: $multiAddonsList, singleAddonsList: $singleAddonsList, optionModel: $optionModel, itemPrice: $itemPrice}';
  }
}