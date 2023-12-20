import 'option_model.dart';

class AddonsListModel {
  String id = '';
  String name = '';
  String code = '';
  String description = '';
  String restaurantId = '';
  String isRequired = '';
  String isActive = '';
  String type = '';
  String addonOrder = '';
  String createdAt = '';
  String updatedAt = '';
  List<OptionModel> opt = [];

  AddonsListModel.empty();

  AddonsListModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.description,
      required this.restaurantId,
      required this.isRequired,
      required this.isActive,
      required this.type,
      required this.addonOrder,
      required this.createdAt,
      required this.updatedAt,
      required this.opt});

  AddonsListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    code = json['code'] ?? '';
    description = json['description'] ?? '';
    restaurantId = json['restaurantId'] ?? '';
    isRequired = json['isRequired'] ?? '';
    isActive = json['isActive'] ?? '';
    type = json['type'] ?? '';
    addonOrder = json['addonOrder'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    if (json['opt'] != null) {
      opt = <OptionModel>[];
      json['opt'].forEach((v) {
        opt.add(OptionModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'AddonsListModel{id: $id, name: $name, code: $code, description: $description, restaurantId: $restaurantId, isRequired: $isRequired, isActive: $isActive, type: $type, addonOrder: $addonOrder, createdAt: $createdAt, updatedAt: $updatedAt, opt: $opt}';
  }
}
