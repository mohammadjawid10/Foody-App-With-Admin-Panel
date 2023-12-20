import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:liefermars/controller/general_screens_controller/custom_navigation_drawer_controller.dart';
import 'package:liefermars/utils/app_constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/common_code.dart';
import '../../utils/user_session_management.dart';
import '../../web_services/user_service.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();
  RxBool emailErrorVisible = RxBool(false);
  RxString emailErrorMsg = "".obs;
  RxBool passwordErrorVisible = RxBool(false);
  RxString passwordErrorMsg = "".obs;
  RxBool obscured = true.obs;

  FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  UserService userService = UserService();
  RxString deviceToken = ''.obs;

  final RxMap<String, dynamic> _userData = <String, dynamic>{}.obs;

  CustomNavigationDrawerController customNavigationDrawerController =
      Get.find(tag: kNavigationDrawerController);

  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value =
          iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value = androidDeviceInfo.id; // unique ID on Android
    }
  }

  bool passwordValidation(String value) {
    if (value.trim() == "") {
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password is required!";
    } else if (value.trim().length < 8 || value.isEmpty) {
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be of at least 8 Characters!";
    } else if (!value.trim().contains(RegExp(r'^(?=.*?[A-Z])'))) {
      passwordErrorVisible.value = true;
      passwordErrorMsg.value =
          "Password should be contain at least 1 capital letter";
    }
    /*else if(!value.trim().contains(RegExp(r'^(?=.*?[.])'))){
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be conatin (.)";
    }*/
    else if (!value.trim().contains(RegExp(r'^(?=.*?[0-9])'))) {
      passwordErrorVisible.value = true;
      passwordErrorMsg.value = "Password should be at least a digit";
    } else {
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

  void toggleObscured() {
    obscured.value = !obscured.value;
    if (passwordFocusNode.hasPrimaryFocus) {
      return;
    }
    passwordFocusNode.canRequestFocus = false;
  }

  void onSignUpTap() {
    Get.toNamed(kSignupScreen);
  }

  Future<void> onLoginTap() async {
    removeAFieldsFocus();
    bool isAllDataValid = false;
    isAllDataValid = !emailValidation(emailTEController.text);
    isAllDataValid =
        !passwordValidation(passwordTEController.text) && isAllDataValid;
    deviceToken.value =
        deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    if (isAllDataValid) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      if (await CommonCode().checkInternetAccess()) {
        String response = await userService.loginUser(
            password: passwordTEController.text,
            email: emailTEController.text,
            deviceToken: deviceToken.value);
        pd.dismissDialog();
        if (response.contains("Success")) {
          emailTEController.clear();
          passwordTEController.clear();
          pd.dismissDialog();
          UserSession userSession = UserSession();
          await userSession.setLogin();
          customNavigationDrawerController.isLoggedIn.value =
              await userSession.isUserLoggedIn();
          Get.back();
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: "Alert", description: response, type: DialogType.ERROR);
        }
      } else {
        pd.dismissDialog();
        CustomDialogs().showMessageDialog(
            title: 'Alert', description: kInternetMsg, type: DialogType.ERROR);
      }
    }
  }

  Future<void> onGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signIn();
      if (googleSignIn.currentUser!.id != '') {
        ProgressDialog pd = ProgressDialog();
        pd.showDialog();
        if (await CommonCode().checkInternetAccess()) {
          deviceToken.value =
              deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
          String response = await userService.socialLoginUser(
              name: googleSignIn.currentUser!.displayName ?? '',
              email: googleSignIn.currentUser!.email,
              deviceToken: deviceToken.value,
              providerId: googleSignIn.currentUser!.id,
              photoUrl: googleSignIn.currentUser!.photoUrl ?? '',
              providerName: 'Google');
          pd.dismissDialog();
          if (response.contains("Success")) {
            emailTEController.clear();
            passwordTEController.clear();
            pd.dismissDialog();
            UserSession userSession = UserSession();
            await userSession.setLogin();
            customNavigationDrawerController.isLoggedIn.value =
                await userSession.isUserLoggedIn();
            Get.back();
          } else {
            pd.dismissDialog();
            CustomDialogs().showMessageDialog(
                title: "Alert", description: response, type: DialogType.ERROR);
          }
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: 'Alert',
              description: kInternetMsg,
              type: DialogType.ERROR);
        }
      }
    } catch (error) {}
  }

  Future<void> fbLoginTap() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile'],
    ); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      _userData.value = userData;
      ProgressDialog pd = ProgressDialog();
      if (await CommonCode().checkInternetAccess()) {
        deviceToken.value =
            deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        String response = await userService.socialLoginUser(
            name: _userData['name'] ?? '',
            email: _userData['email'] ?? '',
            deviceToken: deviceToken.value,
            providerId: _userData['id'],
            photoUrl: _userData['picture']['data']['url'] ?? '',
            providerName: 'Facebook');
        pd.dismissDialog();
        if (response.contains("Success")) {
          emailTEController.clear();
          passwordTEController.clear();
          pd.dismissDialog();
          UserSession userSession = UserSession();
          await userSession.setLogin();
          customNavigationDrawerController.isLoggedIn.value =
              await userSession.isUserLoggedIn();
          Get.back();
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: "Alert", description: response, type: DialogType.ERROR);
        }
      } else {
        pd.dismissDialog();
        CustomDialogs().showMessageDialog(
            title: 'Alert', description: kInternetMsg, type: DialogType.ERROR);
      }
    } else {}
  }

  Future<void> appleLoginTap() async {
    if (!await SignInWithApple.isAvailable()) {
      return null;
    }

    final appleProvider = AppleAuthProvider();
    appleProvider.addScope('email');
    appleProvider.addScope('name');
    appleProvider.addScope('fullName');
    var result = await FirebaseAuth.instance.signInWithProvider(appleProvider);
    if (result.credential?.accessToken != null &&
        result.credential?.accessToken != '') {
      ProgressDialog pd = ProgressDialog();
      if (await CommonCode().checkInternetAccess()) {
        deviceToken.value =
            deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
        String response = await userService.socialLoginUser(
            name: result.additionalUserInfo!.isNewUser
                ? result.user!.displayName ?? ''
                : '',
            email: result.user!.email ?? '',
            deviceToken: deviceToken.value,
            providerId: result.user!.uid ?? '',
            photoUrl: result.user!.photoURL ?? '' ?? '',
            providerName: 'Apple');
        pd.dismissDialog();
        if (response.contains("Success")) {
          emailTEController.clear();
          passwordTEController.clear();
          pd.dismissDialog();
          UserSession userSession = UserSession();
          await userSession.setLogin();
          customNavigationDrawerController.isLoggedIn.value =
              await userSession.isUserLoggedIn();
          Get.back();
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: "Alert", description: response, type: DialogType.ERROR);
        }
      } else {
        pd.dismissDialog();
        CustomDialogs().showMessageDialog(
            title: 'Alert', description: kInternetMsg, type: DialogType.ERROR);
      }
    }
    print(result);

    String generateNonce([int length = 32]) {
      final charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    result = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    print(result);
  }

  Future<bool> onWillPop() {
    removeAFieldsFocus();
    Get.back();
    return Future.value(false);
  }
}
