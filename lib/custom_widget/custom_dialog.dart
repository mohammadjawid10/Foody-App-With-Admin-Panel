import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/app_colors.dart';
import 'image_widget.dart';


class CustomDialogs {
  static final CustomDialogs _instance = CustomDialogs._internal();

  CustomDialogs._internal();

  factory CustomDialogs() => _instance;

  void showMessageDialog(
      {required String title,
        required String description,
        required DialogType type,
        Function? onOkBtnPressed}) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      btnOkColor: type == DialogType.SUCCES ?  AppColors.redColor: AppColors.redColor.withOpacity(0.9),
      title: title,
      dismissOnTouchOutside: false,
      desc: description,
      customHeader: Container(
        margin: const EdgeInsets.all(6),
        child: Image.asset(Img.get('app-icon.png'),height: 80,width: 80),
      ),
      btnOkOnPress: () {
        if (onOkBtnPressed != null) {
          onOkBtnPressed();
        }
      },
    ).show();
  }

  void showDialog(
      String title, String description, DialogType type, Color btnOkColor,
      {Function? onOkBtnPressed}) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      btnOkColor: btnOkColor,
      title: title,
      dismissOnTouchOutside: false,
      desc: description,
      customHeader: Container(
          margin: const EdgeInsets.all(12.0),
          child: Image.asset(Img.get('app-icon.png'),height: 80,width: 80)),
      btnOkOnPress: () {
        if (onOkBtnPressed != null) {
          onOkBtnPressed();
        }
      },
    ).show();
  }

  void showErrorDialog(
      String title, String description, DialogType type, Color btnOkColor,
      {Function? onOkBtnPressed}) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      btnOkColor: btnOkColor,
      title: title,
      dismissOnTouchOutside: false,
      desc: description,
      customHeader: Container(
        margin: const EdgeInsets.all(12.0),
        child: Image.asset(Img.get('app-icon.png'),height: 80,width: 80),),
      btnOkOnPress: () {
        if(onOkBtnPressed != null ){onOkBtnPressed();}
      },
    ).show();
  }

  void confirmationDialog(
      {required String message, required Function yesFunction}) {
    const double padding = 10.0;
    const double avatarRadius = 66.0;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(
                top: padding + 10,
                bottom: padding,
                left: padding + 10,
                right: padding,
              ),
              margin: const EdgeInsets.only(top: avatarRadius),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start, // To make the card compact
                children: <Widget>[
                  const Text(
                    "Confirmation",
                    //textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    message,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Text(
                              "NO",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.redColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            yesFunction();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 15, top: 5, bottom: 5),
                            child: Text(
                              "YES",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  AppColors.redColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void productInfoDialog(
      {required String title, required Function yesFunction,required description}) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,

        backgroundColor: Colors.transparent,
        content: Container(
          height: 200,
          child: Column(
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap:(){
                          Get.back();
                        },
                        child: iconWidget(img: 'cross-icon.png',size: 25,color: AppColors.blackColor.withOpacity(0.5))),
                    Expanded(child: Center(child: Text(title,style: heading1SemiBold(color: AppColors.whiteColor,fontSize: 18),))),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Center(child: Text(description,textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 16),)),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  void uploadImageDialog({required Function onSuccess}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () async {
                Get.back();
                await _permissionHandler(function: ()=>onSuccess(ImageSource.gallery),);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Image.asset(
                    Img.get('gallery-icon.png'),
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "Gallery",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            //const SizedBox(width: 80,),
            GestureDetector(
              onTap: () async {
                Get.back();
                await _permissionHandler(function: ()=>onSuccess(ImageSource.camera),);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Image.asset(
                    Img.get('camera-icon.png'),
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Camera")
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }


  Future _permissionHandler({required VoidCallback function}) async {
    PermissionStatus status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      function();
    } else if (status == PermissionStatus.permanentlyDenied) {
      CustomDialogs().showDialog(
          "Permission Denied",
          "Camera Permission is Permanently Denied\nPlease allow permission from settings and try again.",
          DialogType.ERROR,
          Colors.redAccent);
    } else {
      CustomDialogs().showDialog("Permission Denied",
          "Permission Denied", DialogType.ERROR, Colors.redAccent);
    }
  }

}