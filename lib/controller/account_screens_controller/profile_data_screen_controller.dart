import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

import '../../model/user_info_model.dart';
import '../../web_services/user_service.dart';

class ProfileDataScreenController extends GetxController{

  RxString deviceToken=''.obs;

  UserService userService=UserService();

  Rx<UserInfoModel> userInfoModel=UserInfoModel.empty().obs;

  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
  }



  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      getUserData();
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      getUserData();
    }
  }

  Future<void> getUserData() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    userInfoModel.value=await userService.getUserData(deviceToken: deviceToken.value);
  }
}