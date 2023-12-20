class MyOrdersModel {
  String orderId='';
  String createdAt='';
  String restaurantBanner='';
  String restaurantLogo='';
  String restaurantId='';
  String restaurantName='';
  String overallRating='';
  String restaurantKeywords='';
  String shippingType='';
  String deliveryTime='';
  String viewOrderUrl='';
  String orderAmount='';
  String reviewHashKey='';
  String street='';
  String house='';
  String floor='';
  String address='';
  String address2='';
  String zip='';
  String city='';
  String canGiveReview='';

  MyOrdersModel.empty();

  MyOrdersModel(
      {required this.orderId,
        required this.createdAt,
        required this.restaurantBanner,
        required this.restaurantLogo,
        required this.restaurantId,
        required this.restaurantName,
        required this.overallRating,
        required this.restaurantKeywords,
        required this.shippingType,
        required  this.deliveryTime,
        required  this.viewOrderUrl,
        required this.orderAmount,
        required this.reviewHashKey,
        required  this.street,
        required  this.house,
        required  this.floor,
        required  this.address,
        required  this.address2,
        required  this.zip,
        required  this.city,
        required  this.canGiveReview});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderid']??'';
    createdAt = json['created_at']??'';
    restaurantBanner = json['resturentbanner']??'';
    restaurantLogo = json['resturentlogo']??'';
    restaurantId = json['resturentid']??'';
    restaurantName = json['resturentname']??'';
    overallRating = json['overallrating']??'';
    restaurantKeywords = json['resturentkeywords']??'';
    shippingType = json['shippingtype']??'';
    deliveryTime = json['deliverytime']??'';
    viewOrderUrl = json['vieworderurl']??'';
    orderAmount = json['orderamount']??'';
    reviewHashKey = json['review_hash_key']??'';
    street = json['street']??'';
    house = json['house']??'';
    floor = json['floor']??'';
    address = json['address']??'';
    address2 = json['address_2']??'';
    zip = json['zip']??'';
    city = json['city']??'';
    canGiveReview = json['cangivereview']??'';
  }

  @override
  String toString() {
    return 'MyOrdersModel{orderId: $orderId, createdAt: $createdAt, restaurantBanner: $restaurantBanner, restaurantLogo: $restaurantLogo, restaurantId: $restaurantId, restaurantName: $restaurantName, overallRating: $overallRating, restaurantKeywords: $restaurantKeywords, shippingType: $shippingType, deliveryTime: $deliveryTime, viewOrderUrl: $viewOrderUrl, orderAmount: $orderAmount, reviewHashKey: $reviewHashKey, street: $street, house: $house, floor: $floor, address: $address, address2: $address2, zip: $zip, city: $city, canGiveReview: $canGiveReview}';
  }
}