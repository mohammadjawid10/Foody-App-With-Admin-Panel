class RestaurantTimingModel {
  String day='';
  String delivery='';

 RestaurantTimingModel.empty();

  RestaurantTimingModel.fromJson(Map<String, dynamic> json) {
    day = json['day']??'';
    delivery = json['delivery']??'';
  }

  @override
  String toString() {
    return 'RestaurantTimingModel{day: $day, delivery: $delivery}';
  }
}