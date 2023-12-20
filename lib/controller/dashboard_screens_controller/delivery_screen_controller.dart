import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/user_session_management.dart';

import '../../model/address_model.dart';
import '../../model/user_info_model.dart';
import '../../web_services/user_service.dart';

class DeliveryScreenController extends GetxController {
  TextEditingController streetTEController = TextEditingController();
  TextEditingController houseTEController = TextEditingController();
  TextEditingController apartmentTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();
  TextEditingController zipTEController = TextEditingController();
  TextEditingController floorTEController = TextEditingController();
  TextEditingController companyTEController = TextEditingController();
  TextEditingController emailTEController = TextEditingController();
  TextEditingController phoneTEController = TextEditingController();
  TextEditingController nameTEController = TextEditingController();
  RxBool streetErrorVisible = RxBool(false);
  RxString streetErrorMsg = "".obs;
  RxBool houseErrorVisible = RxBool(false);
  RxString houseErrorMsg = "".obs;
  RxBool zipErrorVisible = RxBool(false);
  RxString zipErrorMsg = "".obs;
  RxBool cityErrorVisible = RxBool(false);
  RxString cityErrorMsg = "".obs;
  RxBool nameErrorVisible = RxBool(false);
  RxString nameErrorMsg = "".obs;
  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;
  RxBool phoneErrorVisible = RxBool(false);
  RxString phoneErrorMsg = "".obs;

  FocusNode nameFocusNode = FocusNode(),
      phoneFocusNode = FocusNode(),
      emailFocusNode = FocusNode();

  FocusNode streetFocusNode = FocusNode(),
      zipFocusNode = FocusNode(),
      apartmentFocusNode = FocusNode(),
      floorFocusNode = FocusNode(),
      houseFocusNode = FocusNode(),
      companyFocusNode = FocusNode(),
      cityFocusNode = FocusNode();
  
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
    log(addressModel.toString());
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    userInfoModel.value=await userService.getUserData(deviceToken: deviceToken.value);
    if(userInfoModel.value.firstname!=''){
      addressModel.value.clientName=userInfoModel.value.firstname;

    }
    if(userInfoModel.value.email!=''){
      addressModel.value.yourEmail=userInfoModel.value.email;

    }
    if(userInfoModel.value.phone!=''){
      addressModel.value.yourPhone=userInfoModel.value.phone;
    }
    userSession.addressInformation(addressModel: addressModel.value);
    getUserAddressInformation();
  }

  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
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


  Future<void> getUserAddressInformation() async{
    streetTEController.text=addressModel.value.street;
    cityTEController.text=addressModel.value.yourCity;
    zipTEController.text=addressModel.value.youZip;
    floorTEController.text=addressModel.value.floor;
    companyTEController.text=addressModel.value.company;
    nameTEController.text=addressModel.value.clientName;
    emailTEController.text=addressModel.value.yourEmail;
    phoneTEController.text=addressModel.value.yourPhone;

  }

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
  
  Future<void> onSave() async{
    userSession.addressInformation(addressModel: AddressModel.forDelivery(street: streetTEController.text, yourAddress: '', yourCity: cityTEController.text, youZip: zipTEController.text, floor: floorTEController.text, company: companyTEController.text, clientName: nameTEController.text, yourPhone: phoneTEController.text, yourEmail: emailTEController.text));
    Get.back(result: true);
  }
}
