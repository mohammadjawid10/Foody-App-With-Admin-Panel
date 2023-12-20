import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressScreenController extends GetxController{
  TextEditingController streetTEController = TextEditingController();
  TextEditingController houseTEController = TextEditingController();
  TextEditingController apartmentTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();
  TextEditingController zipTEController = TextEditingController();
  TextEditingController floorTEController = TextEditingController();
  TextEditingController companyTEController = TextEditingController();
  RxBool streetErrorVisible = RxBool(false);
  RxString streetErrorMsg = "".obs;
  RxBool houseErrorVisible = RxBool(false);
  RxString houseErrorMsg = "".obs;
  RxBool zipErrorVisible = RxBool(false);
  RxString zipErrorMsg = "".obs;
  RxBool cityErrorVisible = RxBool(false);
  RxString cityErrorMsg = "".obs;

  FocusNode streetFocusNode = FocusNode(),
      zipFocusNode = FocusNode(),
      apartmentFocusNode = FocusNode(),
      floorFocusNode = FocusNode(),
      houseFocusNode = FocusNode(),
      companyFocusNode = FocusNode(),
      cityFocusNode = FocusNode();

  bool streetValidation(String value) {
    if (value.trim() == "") {
      streetErrorVisible.value = true;
      streetErrorMsg.value = "required!";
    } else if (value.trim().length < 3 ||
        value.isEmpty) {
      streetErrorVisible.value = true;
      streetErrorMsg.value = "Invalid!";
    }
    else {
      streetErrorVisible.value = false;
      streetErrorMsg.value = "";
    }
    return streetErrorVisible.value;
  }

  bool houseValidation(String value) {
    if (value.trim() == "") {
      houseErrorVisible.value = true;
      houseErrorMsg.value = "required!";
    }
    else {
      houseErrorVisible.value = false;
      houseErrorMsg.value = "";
    }
    return houseErrorVisible.value;
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
    } else if (houseFocusNode.hasFocus) {
      houseFocusNode.unfocus();
    } else if (apartmentFocusNode.hasFocus) {
      apartmentFocusNode.unfocus();
    }else if (cityFocusNode.hasFocus) {
      cityFocusNode.unfocus();
    }else if (zipFocusNode.hasFocus) {
      zipFocusNode.unfocus();
    }else if (floorFocusNode.hasFocus) {
      floorFocusNode.unfocus();
    }else if (companyFocusNode.hasFocus) {
      companyFocusNode.unfocus();
    }
  }
}