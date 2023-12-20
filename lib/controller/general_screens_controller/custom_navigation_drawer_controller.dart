import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/app_constants.dart';
import 'package:liefermars/utils/user_session_management.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../web_services/user_service.dart';

class CustomNavigationDrawerController extends GetxController{

  RxBool isPromotionOption=false.obs;

  RxBool isLoggedIn=false.obs,isGermanLanguage=false.obs,isFirstLogin=false.obs;

  UserSession userSession=UserSession();

  UserService userService=UserService();

  RxString deviceToken=''.obs;

  Future<void> onDrawerItemClick({required String title}) async {
    if(title!="Support" && title!='Language') {
      Get.back();
    }
    if (title == "signin".tr) {
     /* if(isFirstLogin.value){
        Get.toNamed(kWelcomeScreen);
      }else{*/
        Get.toNamed(kLoginScreen);

    }else if (title == "signup".tr) {
      Get.toNamed(kSignupScreen);
    }else if (title == "Support") {
      isPromotionOption.value=!isPromotionOption.value;
    }else if (title == "about".tr) {
      Get.toNamed(kSupportScreen);
    }else if (title == "termsofservice".tr) {
      Get.toNamed(kTermsAndConditionScreen);
    }else if (title == "Restaurants General Terms and condition") {
      Get.toNamed(kRestaurantGeneralTermsAndConditionScreen);
    }else if (title == "Privacy Policy") {
      Get.toNamed(kDataPrivacyScreen);
    }else if (title == "profile".tr) {
      Get.toNamed(kProfileDataScreen);
    }else if (title == "colophon".tr) {
      Get.toNamed(kColophonScreen);
    }else if (title == "Inbox") {
      Get.toNamed(kInboxScreen);
    }else if (title == "order".tr) {
      Get.toNamed(kOrdersScreen);
    }else if (title == "My Address") {
      Get.toNamed(kMyAddressScreen);
    }else if (title == "myreviews".tr) {
      Get.toNamed(kReviewScreen);
    }else if (title == "becomeapartnerrestaurant".tr) {
      Get.toNamed(kBecomeAPartnerScreen);
    }else if (title == "recommendarestaurant".tr) {
      Get.toNamed(kRecommendRestaurantScreen);
    }else if (title == "accountsettings".tr) {
      Get.toNamed(kAccountSettingScreen);
    }else if (title == "deliverylacations".tr) {
      Get.toNamed(kDeliveryLocationScreen);
    }else if(title == "logout".tr){
      CustomDialogs().confirmationDialog(
          message: "Are you sure you want to logout?",
          yesFunction: () async{
            String resp=await userService.userLogOut(sessionId: deviceToken.value);
            if(resp=="you are logout successfully."){
              UserSession().logOut();
              isLoggedIn.value=false;
              isFirstLogin.value=false;
              Get.back();
            }
          }
      );
    }else if(title == "Language"){
      if(isGermanLanguage.value) {
        userSession.setLanguage(false);
        isGermanLanguage.value=false;
        Get.updateLocale(const Locale('en', 'UK'));
      }else{
        userSession.setLanguage(true);
        isGermanLanguage.value=true;
        Get.updateLocale(const Locale('de','GR'));
      }
      print(isGermanLanguage);
    }

  }

  @override
  void onInit() {
    isLogIn();
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    }
  }

  Future<void> isLogIn() async{
    isLoggedIn.value=await userSession.isUserLoggedIn();
    isGermanLanguage.value=await userSession.isGermanLanguage();
    if(!isLoggedIn.value){
     isFirstLogin.value=await userSession.isUserFirstLoggedIn();
    }
  }


}