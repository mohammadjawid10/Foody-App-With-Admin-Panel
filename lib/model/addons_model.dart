import 'addons_list_model.dart';

class AddonsModel {
  String name='';
  AddonsListModel addonsListModel=AddonsListModel.empty();

  AddonsModel({required this.name, required this.addonsListModel});

  AddonsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addonsListModel =AddonsListModel.fromJson(json['addons']??{});
  }

  @override
  String toString() {
    return 'AddonsModel{name: $name, addonsListModel: $addonsListModel}';
  }
}