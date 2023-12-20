import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../web_services/user_service.dart';

class ForgetPasswordScreenController extends GetxController{
  TextEditingController emailTEController = TextEditingController();
  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;
  FocusNode emailFocusNode = FocusNode();

  UserService userService = UserService();

  void removeAFieldsFocus() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool emailValidation(String value) {
    if (value.trim() == "") {
      emailErrorVisible.value = true;
      emailErrorMsg.value = "Email is required!";
    } else if (isValidEmail(value) != true) {
      emailErrorVisible.value = true;
      emailErrorMsg.value = "Invalid Email!";
    } else {
      emailErrorVisible.value = false;
      emailErrorMsg.value = "";
    }
    return emailErrorVisible.value;
  }

  Future<void> onSubmitTap() async {
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid = !emailValidation(emailTEController.text);
    if (isAllDataValid) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if(await CommonCode().checkInternetAccess()) {
        String response = await userService.forgetPasswordUser(email: emailTEController.text);
        pd.dismissDialog();
        if (response.contains("Success")) {
          emailTEController.clear();
          pd.dismissDialog();
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