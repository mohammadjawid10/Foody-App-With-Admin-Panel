import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/user_session_management.dart';
import 'package:liefermars/web_services/restaurant_service.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../model/cart_item_model.dart';
import '../../model/get_cart_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';

class OrderViewScreenController extends GetxController{
  RxList<TextEditingController> notesTEController=<TextEditingController>[].obs;

  RxString status=''.obs;

  RxInt totalQuantity=0.obs;

  Rx<GetCartModel> getCartModel=GetCartModel.empty().obs;

  RxString deviceToken=''.obs;

  RestaurantService restaurantService=RestaurantService();

  UserSession userSession=UserSession();

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    }
  }

  @override
  void onInit() {
    getCartModel.value=Get.arguments[0];
    status.value=Get.arguments[1];
    getTextFieldLength();
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getTextFieldLength() async{
    for(int i=0;i<getCartModel.value.items.length;i++){
      notesTEController.add(TextEditingController());
    }
  }

  Future<void> onCartUpdate({required int totalQ, required CartItemModel cartItemModel,required String text}) async{
    if(await CommonCode().checkInternetAccess()) {
      String response = await restaurantService.updateCart(cartTempId: cartItemModel.temp, notes: text, deviceToken: deviceToken.value, quantity: totalQ.toString());
      if (response=='Cart Updated successfully.') {
       // notesTEController.clear();
        getCartData();
      } else {
        CustomDialogs().showMessageDialog(
            title: "Alert", description: response, type: DialogType.ERROR);
      }
    } else{
      CustomDialogs().showMessageDialog(title: 'Alert',
          description: kInternetMsg,
          type: DialogType.ERROR);
    }
  }

  Future<void> onDeleteCart({required CartItemModel cartItemModel}) async{
    if(await CommonCode().checkInternetAccess()) {
      String response = await restaurantService.removeCart(cartTempId: cartItemModel.temp, deviceToken: deviceToken.value);
      if (response=='Item Deleted!') {
        getCartData();
      } else {
        CustomDialogs().showMessageDialog(
            title: "Alert", description: response, type: DialogType.ERROR);
      }
    } else{
      CustomDialogs().showMessageDialog(title: 'Alert',
          description: kInternetMsg,
          type: DialogType.ERROR);
    }
  }


  Future<void> getCartData() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getCartModel.value=await restaurantService.getCartData(deviceTokenId: deviceToken.value,shipping: status.value);
    for(int i=0;i<getCartModel.value.items.length;i++){
      notesTEController.add(TextEditingController());
    }
  }

  Future<void> onCheckOutTap() async{
      Get.toNamed(kCheckOutScreen,arguments: [getCartModel.value,status.value]);
  }
}