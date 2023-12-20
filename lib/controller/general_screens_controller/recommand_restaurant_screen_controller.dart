import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/web_services/restaurant_service.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';

class RecommendRestaurantScreenController extends GetxController{

  TextEditingController noteTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();
  TextEditingController zipTEController = TextEditingController();
  TextEditingController floorTEController = TextEditingController();
  TextEditingController emailTEController = TextEditingController();
  TextEditingController nameTEController = TextEditingController();
  RxBool noteErrorVisible = RxBool(false);
  RxString noteErrorMsg = "".obs;
  RxBool zipErrorVisible = RxBool(false);
  RxString zipErrorMsg = "".obs;
  RxBool cityErrorVisible = RxBool(false);
  RxString cityErrorMsg = "".obs;
  RxBool nameErrorVisible = RxBool(false);
  RxString nameErrorMsg = "".obs;
  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;

  FocusNode nameFocusNode = FocusNode(),
      emailFocusNode = FocusNode();

  FocusNode streetFocusNode = FocusNode(),
      zipFocusNode = FocusNode(),
      companyFocusNode = FocusNode(),
      cityFocusNode = FocusNode();

  RestaurantService restaurantService = RestaurantService();

  bool nameValidation(String value) {
    if (value.trim() == "") {
      nameErrorVisible.value = true;
      nameErrorMsg.value = "required!";
    } else if (value.trim().length < 3 ||
        value.isEmpty) {
      nameErrorVisible.value = true;
      nameErrorMsg.value = "Invalid!";
    }
    else {
      nameErrorVisible.value = false;
      nameErrorMsg.value = "";
    }
    return nameErrorVisible.value;
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

  bool noteValidation(String value) {
    if (value.trim() == "") {
      noteErrorVisible.value = true;
      noteErrorMsg.value = "required!";
    } else if (value.trim().length < 3 ||
        value.isEmpty) {
      noteErrorVisible.value = true;
      noteErrorMsg.value = "Invalid!";
    }
    else {
      noteErrorVisible.value = false;
      noteErrorMsg.value = "";
    }
    return noteErrorVisible.value;
  }

  bool cityValidation(String value) {
    if (value.trim() == "") {
      cityErrorVisible.value = true;
      cityErrorMsg.value = "required!";
    } else if (value.trim().length < 3 ||
        value.isEmpty) {
      cityErrorVisible.value = true;
      cityErrorMsg.value = "Invalid!";
    }
    else {
      cityErrorVisible.value = false;
      cityErrorMsg.value = "";
    }
    return cityErrorVisible.value;
  }

  bool zipValidation(String value) {
    if (value.trim() == "") {
      zipErrorVisible.value = true;
      zipErrorMsg.value = "required!";
    }else if (value.trim().length < 5) {
      zipErrorVisible.value = true;
      zipErrorMsg.value = "must contain minimum 5 characters";
    }
    else {
      zipErrorVisible.value = false;
      zipErrorMsg.value = "";
    }
    return zipErrorVisible.value;
  }

  void removeAFieldsFocus() {
    if (streetFocusNode.hasFocus) {
      streetFocusNode.unfocus();
    }else if (cityFocusNode.hasFocus) {
      cityFocusNode.unfocus();
    }else if (zipFocusNode.hasFocus) {
      zipFocusNode.unfocus();
    }else if (companyFocusNode.hasFocus) {
      companyFocusNode.unfocus();
    }else if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
  }

  Future<void> onSaveTap() async {
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid = !nameValidation(nameTEController.text);
    isAllDataValid = !zipValidation(zipTEController.text) && isAllDataValid;
    isAllDataValid = !cityValidation(cityTEController.text) && isAllDataValid;
    isAllDataValid = !emailValidation(emailTEController.text) && isAllDataValid;
    isAllDataValid = !noteValidation(noteTEController.text) && isAllDataValid;
    if (isAllDataValid) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if(await CommonCode().checkInternetAccess()) {
        String response = await restaurantService.recommendRestaurant(name: nameTEController.text, email: emailTEController.text, zip: zipTEController.text, city: cityTEController.text, note: noteTEController.text);
        pd.dismissDialog();
        if (response.contains("Success")) {
          emailTEController.clear();
          nameTEController.clear();
          noteTEController.clear();
          zipTEController.clear();
          cityTEController.clear();
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