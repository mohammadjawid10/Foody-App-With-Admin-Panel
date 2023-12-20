class MyReviewsModel {
  String restName='';
  String restLogo='';
  String timeAgo='';
  String date='';
  String time='';
  int qualityRating=0;
  int deliveryRating=0;
  String content='';

  MyReviewsModel.empty();


  MyReviewsModel.fromJson(Map<String, dynamic> json) {
    restName = json['restname']??'';
    restLogo = json['restlogo']??'';
    timeAgo = json['timeago']??'';
    date = json['date']??'';
    time = json['time']??'';
    qualityRating = json['qualityrating']??0;
    deliveryRating = json['deliveryrating']??0;
    content = json['content']??'';
  }

  @override
  String toString() {
    return 'MyReviewsModel{restName: $restName, restLogo: $restLogo, timeAgo: $timeAgo, date: $date, time: $time, qualityRating: $qualityRating, deliveryRating: $deliveryRating, content: $content}';
  }
}