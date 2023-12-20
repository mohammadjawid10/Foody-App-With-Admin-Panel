import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardScreenController extends GetxController{
  TextEditingController cardHolderTEController = TextEditingController();
  TextEditingController cardNum1TEController = TextEditingController();
  TextEditingController cardNum2TEController = TextEditingController();
  TextEditingController cardNum3TEController = TextEditingController();
  TextEditingController cardNum4TEController = TextEditingController();
  TextEditingController expirationDateTEController = TextEditingController();
  TextEditingController cvcTEController = TextEditingController();
  RxBool cardHolderErrorVisible = RxBool(false);
  RxString cardHolderErrorMsg = "".obs;
  RxBool expireDateErrorVisible = RxBool(false);
  RxString expireDateErrorMsg = "".obs;
  RxBool cvcErrorVisible = RxBool(false);
  RxString cvcErrorMsg = "".obs;
  RxBool cardNum1ErrorVisible = RxBool(false);
  RxString cardNum1ErrorMsg = "".obs;
  RxBool cardNum2ErrorVisible = RxBool(false);
  RxString cardNum2ErrorMsg = "".obs;
  RxBool cardNum3ErrorVisible = RxBool(false);
  RxString cardNum3ErrorMsg = "".obs;
  RxBool cardNum4ErrorVisible = RxBool(false);
  RxString cardNum4ErrorMsg = "".obs;

  FocusNode cardHolderFocusNode = FocusNode(),
      expireDateFocusNode = FocusNode(),
      cvcFocusNode = FocusNode(),
      cardNum1FocusNode = FocusNode(),
      cardNum2FocusNode = FocusNode(),
      cardNum3FocusNode = FocusNode(),
      cardNum4FocusNode = FocusNode();

  bool cardHolderValidation(String value) {
    if (value.trim() == "") {
      cardHolderErrorVisible.value = true;
      cardHolderErrorMsg.value = "required!";
    } else if (value.trim().length < 3 ||
        value.isEmpty) {
      cardHolderErrorVisible.value = true;
      cardHolderErrorMsg.value = "Invalid!";
    }
    else {
      cardHolderErrorVisible.value = false;
      cardHolderErrorMsg.value = "";
    }
    return cardHolderErrorVisible.value;
  }

  bool expireDateValidation(String value) {
    if (value.trim() == "") {
      expireDateErrorVisible.value = true;
      expireDateErrorMsg.value = "required!";
    }
    else {
      expireDateErrorVisible.value = false;
      expireDateErrorMsg.value = "";
    }
    return expireDateErrorVisible.value;
  }

  bool cardNum1Validation(String value) {
    if (value.trim() == "") {
      cardNum1ErrorVisible.value = true;
      cardNum1ErrorMsg.value = "required!";
    } else if (value.trim().length < 4 ||
        value.isEmpty) {
      cardNum1ErrorVisible.value = true;
      cardNum1ErrorMsg.value = "Invalid!";
    }
    else {
      cardNum1ErrorVisible.value = false;
      cardNum1ErrorMsg.value = "";
    }
    return cardNum1ErrorVisible.value;
  }

  bool cardNum2Validation(String value) {
    if (value.trim() == "") {
      cardNum2ErrorVisible.value = true;
      cardNum2ErrorMsg.value = "required!";
    } else if (value.trim().length < 4 ||
        value.isEmpty) {
      cardNum2ErrorVisible.value = true;
      cardNum2ErrorMsg.value = "Invalid!";
    }
    else {
      cardNum2ErrorVisible.value = false;
      cardNum2ErrorMsg.value = "";
    }
    return cardNum2ErrorVisible.value;
  }

  bool cardNum3Validation(String value) {
    if (value.trim() == "") {
      cardNum3ErrorVisible.value = true;
      cardNum3ErrorMsg.value = "required!";
    } else if (value.trim().length < 4 ||
        value.isEmpty) {
      cardNum3ErrorVisible.value = true;
      cardNum3ErrorMsg.value = "Invalid!";
    }
    else {
      cardNum3ErrorVisible.value = false;
      cardNum3ErrorMsg.value = "";
    }
    return cardNum3ErrorVisible.value;
  }

  bool cardNum4Validation(String value) {
    if (value.trim() == "") {
      cardNum4ErrorVisible.value = true;
      cardNum4ErrorMsg.value = "required!";
    } else if (value.trim().length < 4 ||
        value.isEmpty) {
      cardNum4ErrorVisible.value = true;
      cardNum4ErrorMsg.value = "Invalid!";
    }
    else {
      cardNum4ErrorVisible.value = false;
      cardNum4ErrorMsg.value = "";
    }
    return cardNum4ErrorVisible.value;
  }

  bool cvcValidation(String value) {
    if (value.trim() == "") {
      cvcErrorVisible.value = true;
      cvcErrorMsg.value = "required!";
    }else if (value.trim().length<3) {
      cvcErrorVisible.value = true;
      cvcErrorMsg.value = "Invalid!";
    }
    else {
      cvcErrorVisible.value = false;
      cvcErrorMsg.value = "";
    }
    return cvcErrorVisible.value;
  }

  void removeAFieldsFocus() {
    if (cardHolderFocusNode.hasFocus) {
      cardHolderFocusNode.unfocus();
    } else if (cardNum2FocusNode.hasFocus) {
      cardNum2FocusNode.unfocus();
    } else if (cvcFocusNode.hasFocus) {
      cvcFocusNode.unfocus();
    }else if (cardNum4FocusNode.hasFocus) {
      cardNum4FocusNode.unfocus();
    }else if (expireDateFocusNode.hasFocus) {
      expireDateFocusNode.unfocus();
    }else if (cardNum1FocusNode.hasFocus) {
      cardNum1FocusNode.unfocus();
    }else if (cardNum3FocusNode.hasFocus) {
      cardNum3FocusNode.unfocus();
    }
  }
}