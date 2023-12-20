import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../web_services/user_service.dart';

class ResetPasswordScreenController extends GetxController{
  TextEditingController passwordTEController = TextEditingController();
  TextEditingController confirmPasswordTEController = TextEditingController();
  RxBool passwordErrorVisible = RxBool(false);
  RxString passwordErrorMsg = "".obs;
  RxBool confirmPasswordErrorVisible = RxBool(false);
  RxString confirmPasswordErrorMsg = "".obs;
  RxBool obscured = true.obs;

  UserService userService = UserService();

  FocusNode passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode();

  RxString deviceToken=''.obs;

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

  bool confirmPasswordValidation(String value) {
    if (value.trim() == "") {
      confirmPasswordErrorVisible.value = true;
      confirmPasswordErrorMsg.value = "Confirm Password is required!";
    }
    else if (!validateBothPassword()) {
      confirmPasswordErrorVisible.value = true;
      confirmPasswordErrorMsg.value = "Passwords does not match";
    } else {
      confirmPasswordErrorVisible.value = false;
      confirmPasswordErrorMsg.value = "";
    }
    return confirmPasswordErrorVisible.value;
  }

  bool passwordValidation(String value) {
    if (value.trim() == "") {
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password is required!";
    } else if (value.trim().length < 8 ||
        value.isEmpty) {
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be of at least 8 Characters!";
    }else if(!value.trim().contains(RegExp(r'^(?=.*?[A-Z])'))){
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be contain at least 1 capital letter";
    }/*else if(!value.trim().contains(RegExp(r'^(?=.*?[.])'))){
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be conatin (.)";
    }*/else if(!value.trim().contains(RegExp(r'^(?=.*?[0-9])'))){
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be at least a digit";
    }
    else {
      passwordErrorVisible.value = false;
      passwordErrorMsg.value = "";
    }
    return passwordErrorVisible.value;
  }


  bool validateBothPassword(){
    return confirmPasswordTEController.text == passwordTEController.text &&
        passwordTEController.text.length >= 8 &&
        confirmPasswordTEController.text.length >= 8;
  }

  void removeAFieldsFocus() {
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    } else if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.unfocus();
    }
  }

  //Methods
  void toggleObscured() {
    obscured.value = !obscured.value;
    if (passwordFocusNode.hasPrimaryFocus) {
      return;
    }
    passwordFocusNode.canRequestFocus = false;
  }

  Future<void> onChangePasswordTap() async {
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid = !passwordValidation(passwordTEController.text);
    isAllDataValid = !confirmPasswordValidation(confirmPasswordTEController.text) && isAllDataValid;
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    if (isAllDataValid) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if(await CommonCode().checkInternetAccess()) {
  /*      String response = await userService.changeUserPassword(password: passwordTEController.text, confirmPassword: confirmPasswordTEController.text, deviceToken: deviceToken.value, oldPassword: oldPasswordTEController.text);
        pd.dismissDialog();
        if (response=='Password changed successfully') {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
            title: "Success",
            description: "Logged In Successfully!",
            type: DialogType.SUCCES,
            onOkBtnPressed: () => Get.back(),
          );
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: "Alert", description: response, type: DialogType.ERROR);
        }*/
      } else{
        pd.dismissDialog();
        CustomDialogs().showMessageDialog(title: 'Alert',
            description: kInternetMsg,
            type: DialogType.ERROR);
      }
    }
  }
}