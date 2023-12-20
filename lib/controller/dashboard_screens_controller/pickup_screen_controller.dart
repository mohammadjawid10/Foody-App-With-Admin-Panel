import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/address_model.dart';
import '../../model/user_info_model.dart';
import '../../utils/user_session_management.dart';
import '../../web_services/user_service.dart';

class PickUpScreenController extends GetxController {
  TextEditingController nameTEController = TextEditingController();
  TextEditingController phoneTEController = TextEditingController();
  TextEditingController emailTEController = TextEditingController();
  RxBool nameErrorVisible = RxBool(false);
  RxString nameErrorMsg = "".obs;
  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;
  RxBool phoneErrorVisible = RxBool(false);
  RxString phoneErrorMsg = "".obs;

  FocusNode nameFocusNode = FocusNode(),
      phoneFocusNode = FocusNode(),
      emailFocusNode = FocusNode();

  UserSession userSession=UserSession();

  Rx<AddressModel> addressModel=AddressModel.empty().obs;


  RxString deviceToken=''.obs;

  UserService userService=UserService();

  Rx<UserInfoModel> userInfoModel=UserInfoModel.empty().obs;




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
    addressModel.value = await userSession.getAddressInformation();
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    userInfoModel.value=await userService.getUserData(deviceToken: deviceToken.value);
    print(userInfoModel.value);
    if(userInfoModel.value.firstname!=''){
      addressModel.value.clientName=userInfoModel.value.firstname;

    }
    if(userInfoModel.value.email!=''){
      addressModel.value.yourEmail=userInfoModel.value.email;

    }
    if(userInfoModel.value.phone!=''){
      addressModel.value.yourPhone=userInfoModel.value.phone;
    }
    userSession.addressInformationForPick(addressModel: addressModel.value);
    getUserAddressInformation();
  }

  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
  }



  Future<void> getUserAddressInformation() async{
      addressModel.value = await userSession.getAddressInformationForPick();

      nameTEController.text=addressModel.value.clientName;
      phoneTEController.text=addressModel.value.yourPhone;
      emailTEController.text=addressModel.value.yourEmail;

  }


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

  bool phoneValidation(String value) {
    if (value.trim() == "") {
      phoneErrorVisible.value = true;
      phoneErrorMsg.value = "required!";
    }
    else {
      phoneErrorVisible.value = false;
      phoneErrorMsg.value = "";
    }
    return phoneErrorVisible.value;
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


  void removeAFieldsFocus() {
    if (nameFocusNode.hasFocus) {
      nameFocusNode.unfocus();
    } else if (phoneFocusNode.hasFocus) {
      phoneFocusNode.unfocus();
    } else if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
  }

  Future<void> onSave() async{
    userSession.addressInformationForPick(addressModel: AddressModel.forPickUp(clientName: nameTEController.text, yourPhone: phoneTEController.text, yourEmail: emailTEController.text));
    Get.back(result: true);
  }
}
