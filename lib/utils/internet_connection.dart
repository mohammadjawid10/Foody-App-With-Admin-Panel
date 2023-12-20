import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/utils/app_colors.dart';

import '../custom_widget/image_widget.dart';

class InternetConnectionCheck {
  late StreamSubscription subscription;
  RxBool isDeviceConnected = false.obs;
  RxBool isAlertSet = false.obs;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected.value =
          await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected.value && isAlertSet.value == false) {
            showDialogBox();
            isAlertSet.value = true;
          }
        },
      );

  showDialogBox() => showDialog(
    context: Get.context!,
    barrierColor: AppColors.whiteColor,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      elevation: 0,
      backgroundColor: AppColors.whiteColor,
      content: Container(
        color: AppColors.whiteColor,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            no_internet_Svg(),
            const SizedBox(
              height: 15,
            ),
            no_internetConnection_Text(),
            Spacer(),
            CustomFilledButton(
                onPress: () async{
              isAlertSet.value = false;
              isDeviceConnected.value =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected.value && isAlertSet.value == false) {
                noInternetConnectionToast();
                showDialogBox();
                isAlertSet.value = true;
              } else if (isDeviceConnected.value &&
                  isAlertSet.value == false) {
                Get.back();
              }
            }, text: 'Try Again',radius: 30,backgroundColor: AppColors.redColor,)
          ],
        ),
      ),
    ),
  );
}




// ignore: non_constant_identifier_names
Widget no_internet_Svg() {
  return Image.asset(Img.get('no-internet.png'));
}

// ignore: non_constant_identifier_names
Widget no_internetConnection_Text() {
  return Column(
    children: [
      Text(
        'Connection  Lost',
        style: headingBold(fontSize: 24,color: AppColors.blackColor),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 15,
      ),
      Text(
        'No internet connection ,check the connection to your network.',
        style: bodyMediumMedium(fontSize: 15,color: AppColors.textColor),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

/*Widget closeButton() {
  return Container(
    alignment: Alignment.center,
    height: 32.0,
    width: 142.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFFFDA8C9)),
    child: const Center(
        child: Text("CLOSE",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700))),
  );
}

Widget backOnlineText() {
  return const Column(
    children: [
      Text("Yay! Looks like you are back\nonline.",
          style: TextStyle(fontWeight: FontWeight.w400)),
    ],
  );
}*/

Future<bool?> noInternetConnectionToast() {
  return Fluttertoast.showToast(
      msg: "No Internet Connection ",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}