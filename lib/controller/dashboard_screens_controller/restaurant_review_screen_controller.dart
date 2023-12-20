import 'package:get/get.dart';

import '../../model/restauant_review_model.dart';

class RestaurantReviewScreenController extends GetxController{

List<RestaurantReviewModel> listOfReview=[];
String restName='';

@override
  void onInit() {
    listOfReview=Get.arguments[0];
    restName=Get.arguments[1];
    super.onInit();
  }
}