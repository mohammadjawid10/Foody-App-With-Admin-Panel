import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:liefermars/web_services/restaurant_service.dart';

import '../../model/get_order_model.dart';

class OrdersScreenController extends GetxController{



  RxString deviceToken=''.obs;

  Rx<GetOrderModel> getOrderModel=GetOrderModel.empty().obs;

  RestaurantService restaurantService =RestaurantService();


  @override
  void onInit() {
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
    getOrderModel.value=await restaurantService.getOrderData(deviceTokenId: deviceToken.value);
  }

}