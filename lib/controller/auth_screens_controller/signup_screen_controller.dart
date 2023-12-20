import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:liefermars/model/user_signup_model.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../utils/user_session_management.dart';
import '../../web_services/user_service.dart';
import '../general_screens_controller/custom_navigation_drawer_controller.dart';

class SignUpScreenController extends GetxController{
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  TextEditingController confirmPasswordTEController = TextEditingController();
  TextEditingController userNameTEController = TextEditingController();
  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;
  RxBool passwordErrorVisible = RxBool(false);
  RxString passwordErrorMsg = "".obs;
  RxBool userNameErrorVisible = RxBool(false);
  RxString userNameErrorMsg = "".obs;
  RxBool confirmPasswordErrorVisible = RxBool(false);
  RxString confirmPasswordErrorMsg = "".obs;
  RxBool obscured = true.obs,isRemember=false.obs;

  FocusNode emailFocusNode = FocusNode(),
      passwordFocusNode = FocusNode(),
      confirmPasswordFocusNode = FocusNode(),
      userNameFocusNode = FocusNode();

  UserSignUpModel _userSignUpModel = UserSignUpModel.empty();
  UserService userService = UserService();
  RxString deviceToken=''.obs;

  final RxMap<String, dynamic> _userData=<String,dynamic>{}.obs;

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
      deviceToken.value= iosDeviceInfo.identifierForVendor??''; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;// unique ID on Android
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

  void removeAFieldsFocus() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    } else if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    } else if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.unfocus();
    }else if (userNameFocusNode.hasFocus) {
      userNameFocusNode.unfocus();
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

  bool usernameValidation(String value) {
    if (value.trim() == "") {
      userNameErrorVisible.value = true;
      userNameErrorMsg.value = "Username is required!";
    } else if (value.trim().length<3) {
      userNameErrorVisible.value = true;
      userNameErrorMsg.value = "Invalid Username!";
    } else {
      userNameErrorVisible.value = false;
      userNameErrorMsg.value = "";
    }
    return userNameErrorVisible.value;
  }

  //Methods
  void toggleObscured() {
    obscured.value = !obscured.value;
    if (passwordFocusNode.hasPrimaryFocus) {
      return;
    }
    passwordFocusNode.canRequestFocus = false;
  }

  bool validateBothPassword(){
    return confirmPasswordTEController.text == passwordTEController.text &&
        passwordTEController.text.length >= 8 &&
        confirmPasswordTEController.text.length >= 8;
  }

  void isRememberMeTap(){
      isRemember.value = !isRemember.value;
  }

  Future<void> registerButtonPressed() async {
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid = !emailValidation(emailTEController.text);
    isAllDataValid = !usernameValidation(userNameTEController.text) && isAllDataValid;
    isAllDataValid = !passwordValidation(passwordTEController.text) && isAllDataValid;
    isAllDataValid = !confirmPasswordValidation(confirmPasswordTEController.text) && isAllDataValid;
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    if (isAllDataValid) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if(await CommonCode().checkInternetAccess()) {
        _userSignUpModel = UserSignUpModel(userEmail: emailTEController.text, userPassword: passwordTEController.text, userConfirmPassword: confirmPasswordTEController.text, sessionId: deviceToken.value,userName: userNameTEController.text);
        String response = await userService.signUpUser(_userSignUpModel);
        pd.dismissDialog();
        if (response.contains("User created successfully.")) {
          emailTEController.clear();
          passwordTEController.clear();
          confirmPasswordTEController.clear();
          userNameTEController.clear();
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

  Future<void> onGoogleSignIn() async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signIn();
      if(googleSignIn.currentUser!.id!=''){
        ProgressDialog pd = ProgressDialog();
        pd.showDialog();
        if(await CommonCode().checkInternetAccess()) {
          deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
          String response = await userService.socialLoginUser(name: googleSignIn.currentUser!.displayName??'', email: googleSignIn.currentUser!.email, deviceToken: deviceToken.value, providerId: googleSignIn.currentUser!.id, photoUrl: googleSignIn.currentUser!.photoUrl??'', providerName: 'Google');
          pd.dismissDialog();
          if (response.contains("Success")) {
            emailTEController.clear();
            passwordTEController.clear();
            pd.dismissDialog();
            UserSession userSession = UserSession();
            await userSession.setLogin();
            customNavigationDrawerController.isLoggedIn.value=await userSession.isUserLoggedIn();
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

    } catch (error) {
    }
  }

  Future<void> fbLoginTap() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile'],
    ); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData.value = userData;
      ProgressDialog pd = ProgressDialog();
      if(await CommonCode().checkInternetAccess()) {
        deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        String response = await userService.socialLoginUser(name: _userData['name']??'', email: _userData['email']??'', deviceToken: deviceToken.value, providerId: _userData['id'], photoUrl: _userData['picture']['data']['url']??'', providerName: 'Facebook');
        pd.dismissDialog();
        if (response.contains("Success")) {
          emailTEController.clear();
          passwordTEController.clear();
          pd.dismissDialog();
          UserSession userSession = UserSession();
          await userSession.setLogin();
          customNavigationDrawerController.isLoggedIn.value=await userSession.isUserLoggedIn();
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

    } else {
    }

  }

  Future<bool> onWillPop() {
    removeAFieldsFocus();
    Get.back();
    return Future.value(false);
  }
}