import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liefermars/web_services/user_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../model/user_info_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../utils/permission_handler.dart';

class ProfileScreenController extends GetxController {
  RxString selectedValue = 'Male'.obs;
  RxString deviceToken=''.obs;
  RxString profileImage='Choose File'.obs;

  UserService userService=UserService();

  Rx<UserInfoModel> userInfoModel=UserInfoModel.empty().obs;

  TextEditingController firstNameTEController = TextEditingController();
  TextEditingController lastNameTEController = TextEditingController();
  TextEditingController phoneNumberNameTEController = TextEditingController();
  TextEditingController emailAddressTEController = TextEditingController();
  TextEditingController zipTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();

  FocusNode emailFocusNode = FocusNode(),
      firstNameFocusNode = FocusNode(),
      lastNameFocusNode = FocusNode(),
      zipFocusNode = FocusNode(),
      cityFocusNode = FocusNode(),
      phoneNumberNameFocusNode = FocusNode();

  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;
  RxBool firstNameErrorVisible = RxBool(false);
  RxString firstNameErrorMsg = "".obs;
  RxBool lastNameErrorVisible = RxBool(false);
  RxString lastNameErrorMsg = "".obs;
  RxBool phoneErrorVisible = RxBool(false);
  RxString phoneErrorMsg = "".obs;
  RxBool zipErrorVisible = RxBool(false);
  RxString zipErrorMsg = "".obs;
  RxBool cityErrorVisible = RxBool(false);
  RxString cityErrorMsg = "".obs;
  RxBool profileErrorVisible = RxBool(false);
  RxString profileErrorMsg = "".obs;

  void removeAFieldsFocus() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    } else if (firstNameFocusNode.hasFocus) {
      firstNameFocusNode.unfocus();
    }else if (lastNameFocusNode.hasFocus) {
      lastNameFocusNode.unfocus();
    }else if (phoneNumberNameFocusNode.hasFocus) {
      phoneNumberNameFocusNode.unfocus();
    }else if (zipFocusNode.hasFocus) {
      zipFocusNode.unfocus();
    }else if (cityFocusNode.hasFocus) {
      cityFocusNode.unfocus();
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool emailValidation(String value) {
     if (isValidEmail(value) != true || emailAddressTEController.text=='') {
      emailErrorVisible.value = true;
      emailErrorMsg.value = "Invalid Email!";
    } else {
      emailErrorVisible.value = false;
      emailErrorMsg.value = "";
    }
    return emailErrorVisible.value;
  }

  bool fNameValidation(String value) {
    if (value.trim().length < 5 || value.trim()=='') {
      firstNameErrorVisible.value = true;
      firstNameErrorMsg.value = "Inavlid! Should be greater than 4";
    }
    else {
      firstNameErrorVisible.value = false;
      firstNameErrorMsg.value = "";
    }
    return firstNameErrorVisible.value;
  }

  bool lNameValidation(String value) {
    if (value.trim().length < 5|| value.trim()=='') {
      lastNameErrorVisible.value = true;
      lastNameErrorMsg.value = "Inavlid! Should be greater than 4";
    }
    else {
      lastNameErrorVisible.value = false;
      lastNameErrorMsg.value = "";
    }
    return lastNameErrorVisible.value;
  }

  bool cityValidation(String value) {
    if (value.trim().length < 5|| value.trim()=='') {
      cityErrorVisible.value = true;
      cityErrorMsg.value = "Inavlid! Should be greater than 4";
    }
    else {
      cityErrorVisible.value = false;
      cityErrorMsg.value = "";
    }
    return cityErrorVisible.value;
  }

  bool zipValidation(String value) {
    if (value.trim().length < 5|| value.trim()=='') {
      zipErrorVisible.value = true;
      zipErrorMsg.value = "Inavlid! Should be greater than 4";
    }
    else {
      zipErrorVisible.value = false;
      zipErrorMsg.value = "";
    }
    return zipErrorVisible.value;
  }

  bool phoneValidation(String value) {
    if (value.trim().length < 3|| value.trim()=='') {
      phoneErrorVisible.value = true;
      phoneErrorMsg.value = "Inavlid!";
    }
    else {
      phoneErrorVisible.value = false;
      phoneErrorMsg.value = "";
    }
    return phoneErrorVisible.value;
  }



  @override
  void onInit() {
    userInfoModel.value=Get.arguments;
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
    if(userInfoModel.value.userId!=''){
      lastNameTEController.text=userInfoModel.value.lastname;
      emailAddressTEController.text=userInfoModel.value.email;
      firstNameTEController.text=userInfoModel.value.firstname;
      phoneNumberNameTEController.text=userInfoModel.value.phone;
      phoneNumberNameTEController.text=userInfoModel.value.phone;
      zipTEController.text=userInfoModel.value.zip;
      cityTEController.text=userInfoModel.value.city;
      selectedValue.value=userInfoModel.value.gender;
      profileImage.value=userInfoModel.value.profileImg;
      if(profileImage.value==''){
        profileImage.value='Choose File';
      }
      if(selectedValue.value==''){
        selectedValue.value='Male';
      }
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
  }

  Future<void> onUploadImage() async{
    try{
      bool hasCameraPermission=await PermissionsHandler().requestPermission(permission: Permission.camera,
        onPermissionDenied:(){
          CustomDialogs().showErrorDialog(
            kPermissionDenied,
            kCameraPermissionDenied,
            DialogType.ERROR,
            Colors.red,
          );
        },
        onPermissionPermanentlyDenied: (){

          CustomDialogs().showErrorDialog(
            kPermissionDenied,
            "Camera $kPermissionPermanentlyDenied",
            DialogType.ERROR,
            Colors.red,
          );
        },
      );
      if(hasCameraPermission) {
        CustomDialogs().uploadImageDialog(onSuccess: (source){onImagePick(source);});
      }
    }catch (e){
    }
  }
  Future<void> onImagePick(ImageSource source) async {
    ProgressDialog progressDialog = ProgressDialog();
    progressDialog.showDialog();
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if(pickedImage!=null){
        int index = pickedImage.path.lastIndexOf('/');
        if (index != -1) {
          File file = File(pickedImage.path);
          File compressedImage = await CommonCode().compressImage(file);
          profileImage.value=compressedImage.path;
          if (await CommonCode().checkInternetConnection()) {
            progressDialog.dismissDialog();
          } else {
            progressDialog.dismissDialog();
            CustomDialogs().showMessageDialog(
                title: 'Alert', description: kInternetMsg, type: DialogType.ERROR);
          }

        }
      }
      progressDialog.dismissDialog();
    }
    catch(exception){
      progressDialog.dismissDialog();
    }
  }

  Future<void> onUpdateButton() async{
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid =  !fNameValidation(firstNameTEController.value.text);
    isAllDataValid = !lNameValidation(lastNameTEController.value.text)  && isAllDataValid;
    isAllDataValid = !phoneValidation(phoneNumberNameTEController.value.text) && isAllDataValid;
    isAllDataValid = !emailValidation(emailAddressTEController.value.text) && isAllDataValid;
    isAllDataValid = !zipValidation(zipTEController.value.text) && isAllDataValid;
    isAllDataValid = !cityValidation(cityTEController.value.text) && isAllDataValid;
    userInfoModel.value=UserInfoModel(userId: '', firstname: firstNameTEController.text, lastname: lastNameTEController.text, email: emailAddressTEController.text, profileImg: profileImage.value, city: cityTEController.text, zip: zipTEController.text, phone: phoneNumberNameTEController.text, sessionId: deviceToken.value, gender: selectedValue.value);
    if(isAllDataValid){
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if(await CommonCode().checkInternetAccess()) {
        deviceToken.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        String userLoginModelResp = await UserService().upDateProfile(userInfoModel:userInfoModel.value);
        if (userLoginModelResp=='Your profile has been successfully updated.') {
          pd.dismissDialog();
         Get.back();
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(title: "Alert",
              description: userLoginModelResp,
              type: DialogType.ERROR);
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