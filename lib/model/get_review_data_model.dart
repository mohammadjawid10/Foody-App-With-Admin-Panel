class GetReviewDataModel {
  List<DeliveryTimeModel> deliveryTime=[];
  List<ShowNamesModel> showNames=[];

  GetReviewDataModel.empty();

  GetReviewDataModel({required this.deliveryTime, required this.showNames});

  GetReviewDataModel.fromJson(Map<String, dynamic> json) {
    if (json['delivery_time'] != null) {
      deliveryTime = <DeliveryTimeModel>[];
      json['delivery_time'].forEach((v) {
        deliveryTime.add(DeliveryTimeModel.fromJson(v));
      });
    }
    if (json['shownameas'] != null) {
      showNames = <ShowNamesModel>[];
      json['shownameas'].forEach((v) {
        showNames.add(ShowNamesModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'GetReviewDataModel{deliveryTime: $deliveryTime, showNames: $showNames}';
  }
}

class DeliveryTimeModel {
  String time='';
  String value='';

  DeliveryTimeModel.empty();

  DeliveryTimeModel({required this.time, required this.value});

  DeliveryTimeModel.fromJson(Map<String, dynamic> json) {
    time = json['time']??'';
    value = json['value']??'';
  }

  @override
  String toString() {
    return 'DeliveryTimeModel{time: $time, value: $value}';
  }
}

class ShowNamesModel {
  String name='';
  String value='';

  ShowNamesModel.empty();

  ShowNamesModel({required this.name, required this.value});

  ShowNamesModel.fromJson(Map<String, dynamic> json) {
    name = json['name']??'';
    value = json['value']??'';
  }

  @override
  String toString() {
    return 'ShowNamesModel{name: $name, value: $value}';
  }
}