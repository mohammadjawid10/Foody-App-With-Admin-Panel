import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/get_order_detail_model.dart';
import '../../model/my_orders_model.dart';
import '../../web_services/restaurant_service.dart';

class OrderDetailScreenController extends GetxController{
  TextEditingController textEditingController=TextEditingController();

  MyOrdersModel myOrdersModel=MyOrdersModel.empty();

  RxString deviceToken=''.obs;

  Rx<GetOrderDetailModel> getOrderModel=GetOrderDetailModel.empty().obs;

  RestaurantService restaurantService =RestaurantService();


  @override
  void onInit() {
    myOrdersModel=Get.arguments;
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      getOrders();
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      getOrders();
    }
  }


  Future<void> getOrders() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getOrderModel.value=await restaurantService.getOrderDetail(deviceTokenId: deviceToken.value, orderId: myOrdersModel.orderId);


  }


}