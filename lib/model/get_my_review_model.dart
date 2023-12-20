import 'my_review_model.dart';

class GetMyReviewModel {
  List<MyReviewsModel> myReviews=[];
  int showingTotalReviews=0;
  int totalReviews=0;

  GetMyReviewModel.empty();

  GetMyReviewModel(
      {required this.myReviews,
        required this.showingTotalReviews,
        required this.totalReviews});

  GetMyReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['my_reviews'] != null) {
      myReviews = <MyReviewsModel>[];
      json['my_reviews'].forEach((v) {
        myReviews.add(MyReviewsModel.fromJson(v));
      });
    }
    showingTotalReviews = json['showingtotalreviews']??0;
    totalReviews = json['totalreviews']??0;
  }

  @override
  String toString() {
    return 'GetMyReviewModel{myReviews: $myReviews, showingTotalReviews: $showingTotalReviews, totalReviews: $totalReviews}';
  }
}


