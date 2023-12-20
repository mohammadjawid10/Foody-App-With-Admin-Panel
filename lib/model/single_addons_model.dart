class SingleAddonsModel {
  int addonid=0;
  String addonname='';
  int addonprice=0;

  SingleAddonsModel({required this.addonid, required this.addonname, required this.addonprice});

  SingleAddonsModel.fromJson(Map<String, dynamic> json) {
    addonid = json['addonid']??0;
    addonname = json['addonname']??'';
    addonprice = json['addonprice'] is double?json['addonprice'].toInt():json['addonprice']??0;
  }


}