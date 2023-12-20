class RestaurantModel {
  String name='';
  String code='';
  String banner='';
  String image='';
  String url='';
  int isOpen=-1;
  String slug='';
  String categories='';
  String minOrder='';
  String freeDelivery='';
  String deliveryFee='';
  String deliveryTime='';
  String distance='';
  String city='';
  String zip='';
  String delivery='';
  String pickup='';
  String overallRating='';


  RestaurantModel.empty();

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    name = json['name']??'';
    code = json['code']??'';
    slug=json['slug']??'';
    isOpen=json['is_open']??(-1);
    banner = json['banner']??'';
    image = json['image']??'';
    url = json['url']??'';
    categories = json['categories']??'';
    minOrder = json['minorder']??'';
    freeDelivery = json['free_delivery']??'';
    deliveryFee = json['delivery_fee']??'';
    deliveryTime = json['deliveryTime']??'';
    distance = json['distance']??'';
    city = json['city']??'';
    zip = json['zip']??'';
    delivery = json['delivery']??'';
    pickup = json['pickup']??'';
    overallRating = json['overall_rating']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['banner'] = banner;
    data['image'] = image;
    data['url'] = url;
    data['categories'] = categories;
    data['minorder'] = minOrder;
    data['free_delivery'] = freeDelivery;
    data['delivery_fee'] = deliveryFee;
    data['deliveryTime'] = deliveryTime;
    data['distance'] = distance;
    data['city'] = city;
    data['zip'] = zip;
    data['delivery'] = delivery;
    data['pickup'] = pickup;
    data['overall_rating'] = overallRating;
    return data;
  }

  @override
  String toString() {
    return 'RestaurantModel{name: $name, code: $code, banner: $banner, image: $image, url: $url, categories: $categories, minOrder: $minOrder, freeDelivery: $freeDelivery, deliveryFee: $deliveryFee, deliveryTime: $deliveryTime, distance: $distance, city: $city, zip: $zip, delivery: $delivery, pickup: $pickup, overallRating: $overallRating}';
  }
}