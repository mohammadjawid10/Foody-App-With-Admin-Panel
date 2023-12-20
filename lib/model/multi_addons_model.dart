class MultiAddonsModel {
  String multiAddonId='';
  String multiAddonName='';
  int multiAddonPrice=0;

  MultiAddonsModel.empty();

  MultiAddonsModel(
      {required this.multiAddonId, required this.multiAddonName, required this.multiAddonPrice});

  MultiAddonsModel.fromJson(Map<String, dynamic> json) {
    multiAddonId = json['multiaddonid']??'';
    multiAddonName = json['multiaddonname']??'';
    multiAddonPrice = json['mutliaddonprice'] is double?json['mutliaddonprice'].toInt():json['mutliaddonprice']??0;
  }

  @override
  String toString() {
    return 'MultiAddonsModel{multiAddonId: $multiAddonId, multiAddonName: $multiAddonName, multiAddonPrice: $multiAddonPrice}';
  }
}