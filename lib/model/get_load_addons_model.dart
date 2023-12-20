import 'package:liefermars/model/addons_list_model.dart';

class GetLoadAddonsModel {
  List<AddonsListModel> listOfAddons=[];

  GetLoadAddonsModel.empty();
  GetLoadAddonsModel({required this.listOfAddons});

  GetLoadAddonsModel.fromJson(Map<String, dynamic> json) {
    if (json['addons'] != null) {
      listOfAddons = <AddonsListModel>[];
      json['addons'].forEach((v) {
        listOfAddons.add(AddonsListModel.fromJson(v));
      });
    }
  }


  @override
  String toString() {
    return 'GetLoadAddons{listOfAddons: $listOfAddons}';
  }
}