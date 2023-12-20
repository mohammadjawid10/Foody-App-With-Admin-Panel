import 'addons_model.dart';

class GetMenuOptionModel {
  String banner = '';
  String title = '';
  String image = '';
  List<AddonsModel> addons = [];
  OptionsModel options = OptionsModel.empty();
  String description = '';
  String restaurant = '';
  String price = '';
  String hPrice = '';

  GetMenuOptionModel.empty();

  GetMenuOptionModel(
      {required this.banner,
      required this.title,
      required this.image,
      required this.addons,
      required this.options,
      required this.description,
      required this.restaurant,
      required this.price,
      required this.hPrice});

  GetMenuOptionModel.fromJson(Map<String, dynamic> json) {
    banner = json['banner'] ?? '';
    title = json['title'] ?? '';
    image = json['image'] ?? '';
    if (json['addons'] != null) {
      addons = <AddonsModel>[];
      json['addons'].forEach((v) {
        addons.add(AddonsModel.fromJson(v));
      });
    }
    options = OptionsModel.fromJson(json['options'] ?? {});
    description = json['description'] ?? '';
    restaurant = json['restaurant'] ?? '';
    price = json['price'] ?? '';
    hPrice = json['hPrice'] ?? '';
  }

  @override
  String toString() {
    return 'GetMenuOptionModel{banner: $banner, title: $title, image: $image, addons: $addons, options: $options, description: $description, restaurant: $restaurant, price: $price, hPrice: $hPrice}';
  }
}

class OptionsModel {
  String optionName = '';
  List<OptionItemModel> optionItemList = [];

  OptionsModel.empty();
  OptionsModel({required this.optionName, required this.optionItemList});

  OptionsModel.fromJson(Map<String, dynamic> json) {
    optionName = json['optionname'] ?? '';
    if (json['optionarr'] != null) {
      json['optionarr'].forEach((v) {
        optionItemList.add(OptionItemModel.fromJson(v));
      });
    } else {
      optionItemList = <OptionItemModel>[];
    }
  }

  @override
  String toString() {
    return 'OptionsModel{optionname: $optionName, optionarr: $optionItemList}';
  }
}

class OptionItemModel {
  String id = '';
  String orderNumber = '';
  String menuId = '';
  String name = '';
  String price = '';
  String increase = '';

  OptionItemModel.empty();

  OptionItemModel(
      {required this.id,
      required this.orderNumber,
      required this.menuId,
      required this.name,
      required this.price,
      required this.increase});

  OptionItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    orderNumber = json['order_number'] ?? '';
    menuId = json['menu_id'] ?? '';
    name = json['name'] ?? '';
    price = json['price'] ?? '';
    increase = json['increase'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['menu_id'] = this.menuId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['increase'] = this.increase;
    return data;
  }

  @override
  String toString() {
    return 'OptionItemModel{id: $id, orderNumber: $orderNumber, menuId: $menuId, name: $name, price: $price, increase: $increase}';
  }
}
