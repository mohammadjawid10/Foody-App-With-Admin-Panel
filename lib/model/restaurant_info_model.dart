class RestaurantInfoModel {
  String deliveryCost='';
  String minOrderAmount='';

  RestaurantInfoModel.empty();


  RestaurantInfoModel.fromJson(Map<String, dynamic> json) {
    deliveryCost = json['deliverycost']??'';
    minOrderAmount = json['minorderamount']??'';
  }

  @override
  String toString() {
    return 'RestaurantInfoModel{deliveryCost: $deliveryCost, minOrderAmount: $minOrderAmount}';
  }
}