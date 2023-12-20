import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../utils/user_session_management.dart';
import '../../web_services/user_service.dart';
import '../general_screens_controller/custom_navigation_drawer_controller.dart';

class DeleteAccountScreenController extends GetxController{
  TextEditingController oldPasswordTEController = TextEditingController();
  RxBool oldPasswordErrorVisible = RxBool(false);
  RxString oldPasswordErrorMsg = "".obs;
  RxBool obscured = true.obs;


  FocusNode oldPasswordFocusNode = FocusNode();

  RxString deviceToken=''.obs;
  UserService userService = UserService();

  CustomNavigationDrawerController customNavigationDrawerController=Get.find(tag: kNavigationDrawerController);

  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value =
          iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value = androidDeviceInfo.id; // unique ID on Android
    }
  }


  bool oldPasswordValidation(String value) {
    if (value.trim() == "") {
      oldPasswordErrorVisible.value = true;
      oldPasswordErrorMsg.value = "Password is required!";
    } else if (value.trim().length < 8 ||
        value.isEmpty) {
      oldPasswordErrorVisible.value = true;
      oldPasswordErrorMsg.value = "Password should be of at least 8 Characters!";
    }else if(!value.trim().contains(RegExp(r'^(?=.*?[A-Z])'))){
      oldPasswordErrorVisible.value = true;
      oldPasswordErrorMsg.value = "Password should be contain at least 1 capital letter";
    }else if(!value.trim().contains(RegExp(r'^(?=.*?[0-9])'))) {
      oldPasswordErrorVisible.value = true;
      oldPasswordErrorMsg.value = "Password should be at least a digit";
    }
    else {
      oldPasswordErrorVisible.value = false;
      oldPasswordErrorMsg.value = "";
    }
    return oldPasswordErrorVisible.value;
  }


  void removeAFieldsFocus() {
    if (oldPasswordFocusNode.hasFocus) {
      oldPasswordFocusNode.unfocus();
    }
  }

  //Methods
  void toggleObscured() {
    obscured.value = !obscured.value;
    if (oldPasswordFocusNode.hasPrimaryFocus) {
      return;
    }
    oldPasswordFocusNode.canRequestFocus = false;
  }

  Future<void> onDeleteAccount() async{
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid = !oldPasswordValidation(oldPasswordTEController.text);
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    if (isAllDataValid) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if(await CommonCode().checkInternetAccess()) {
        String response = await userService.deleteUser(deviceToken: deviceToken.value, password: oldPasswordTEController.text);
        pd.dismissDialog();
        if (response=='Success') {
          pd.dismissDialog();
          customNavigationDrawerController.isLoggedIn.value=false;
          UserSession().logOut();
          customNavigationDrawerController.isFirstLogin.value=false;
          Get.back();
          Get.back();
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: "Alert", description: response, type: DialogType.ERROR);
        }
      } else{
        pd.dismissDialog();
        CustomDialogs().showMessageDialog(title: 'Alert',
            description: kInternetMsg,
            type: DialogType.ERROR);
      }
    }
  }

}