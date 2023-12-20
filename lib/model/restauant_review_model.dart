class RestaurantReviewModel {
  String userProfileImg='';
  String userName='';
  String timeAgo='';
  String date='';
  String time='';
  int foodQualityRating=-1;
  int deliveryRating=-1;
  String content='';

  RestaurantReviewModel.empty();

  RestaurantReviewModel(
      {required this.userProfileImg,
        required this.userName,
        required this.timeAgo,
        required this.date,
        required this.time,
        required this.foodQualityRating,
        required this.deliveryRating,
        required this.content});

  RestaurantReviewModel.fromJson(Map<String, dynamic> json) {
    userProfileImg = json['userprofileimg']??'';
    userName = json['username']??'';
    timeAgo = json['timeago']??'';
    date = json['date']??'';
    time = json['time']??'';
    foodQualityRating = json['foodqualityrating']??-1;
    deliveryRating = json['deliveryrating']??-1;
    content = json['content']??'';
  }

  @override
  String toString() {
    return 'RestaurantReviewModel{userProfileImg: $userProfileImg, userName: $userName, timeAgo: $timeAgo, date: $date, time: $time, foodQualityRating: $foodQualityRating, deliveryRating: $deliveryRating, content: $content}';
  }
}