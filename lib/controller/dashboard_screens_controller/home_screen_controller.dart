import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/category_model.dart';
import '../../model/get_restaurants_model.dart';
import '../../model/restaurant_model.dart';
import '../../web_services/restaurant_service.dart';

class HomeScreenController extends GetxController with GetTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late Rx<TabController> tabController;

  RestaurantService restaurantService=RestaurantService();

  RxString deviceToken=''.obs;

  GetRestaurantModel getRestaurantModel=GetRestaurantModel.empty();

  RxList<CategoryModel> listOfCategoryModel=<CategoryModel>[CategoryModel(id: '-1', title: 'All', code: '-1', description: 'all items')].obs;

  RxList<RestaurantModel> listOfRestaurant=<RestaurantModel>[].obs;


  RxString city =''.obs, zip=''.obs;


  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      getRestaurantData();
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      getRestaurantData();
    }
  }

  Future<void> getRestaurantData() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getRestaurantModel=await restaurantService.getRestaurantData(city: city.value, zip: zip.value, page: '1', deviceUniqueId: deviceToken.value,type: 'pickup');
    listOfCategoryModel.value=getRestaurantModel.categoryList;
    tabController=TabController(length: listOfCategoryModel.length, vsync: this).obs;

    listOfRestaurant.value=getRestaurantModel.restaurantList;

  }

  Future<void> getRestaurantDataFilter({String openNow='0',String freeDelivery='0',String rating='0',String minimunOrder='0'}) async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getRestaurantModel=await restaurantService.getRestaurantDataFilter(city: city.value, zip: zip.value, page: '1', deviceUniqueId: deviceToken.value,type: 'pickup', openNow: openNow, minimumAmount: minimunOrder, rating: rating,freeDelivery: freeDelivery);
    listOfCategoryModel.value=getRestaurantModel.categoryList;
    tabController=TabController(length: listOfCategoryModel.length, vsync: this).obs;

    listOfRestaurant.value=getRestaurantModel.restaurantList;

  }


  Future<void> onTabChange({required String catId}) async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getRestaurantModel=await restaurantService.getRestaurantDataByCategory(city: city.value, zip: zip.value, page: '1', deviceUniqueId: deviceToken.value,catId: catId);

    listOfRestaurant.value=getRestaurantModel.restaurantList;
  }
}
