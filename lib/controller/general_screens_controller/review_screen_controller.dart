import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:liefermars/model/get_my_review_model.dart';

import '../../web_services/restaurant_service.dart';

class ReviewScreenController extends GetxController{


  RxString deviceToken=''.obs;

  Rx<GetMyReviewModel> getOrderModel=GetMyReviewModel.empty().obs;

  RestaurantService restaurantService =RestaurantService();


  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      getMyReview();
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      getMyReview();
    }
  }


  Future<void> getMyReview() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getOrderModel.value=await restaurantService.getMyReview(deviceTokenId: deviceToken.value);
    print(getOrderModel.toString());


  }

}