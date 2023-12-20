import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/model/restauant_review_model.dart';
import 'package:liefermars/model/restaurant_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../model/category_model.dart';
import '../../model/get_cart_model.dart';
import '../../model/get_restaurant_menu_model.dart';
import '../../model/menu_model.dart';
import '../../model/menu_model_by_category.dart';
import '../../web_services/restaurant_service.dart';

class RestaurantDetailScreenController extends GetxController with GetTickerProviderStateMixin{

  RxString status=''.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late Rx<TabController> tabController;

  RestaurantModel restaurantModel=RestaurantModel.empty();

  RestaurantService restaurantService=RestaurantService();

  RxString deviceToken=''.obs;

  GetRestaurantMenuModel getRestaurantMenuModel=GetRestaurantMenuModel.empty();

  Rx<GetCartModel> getCartModel=GetCartModel.empty().obs;

  RxList<CategoryModel> listOfCategoryModel=<CategoryModel>[].obs;

  RxList<MenuModel> listOfRestaurantMenuModel=<MenuModel>[].obs;

  RxList<MenuModelByCategory> listOfRestaurantMenuModelByCategory=<MenuModelByCategory>[].obs;

  RxList<MenuModelByCategory> listOfRestaurantMenuModelByCategoryForAll=<MenuModelByCategory>[].obs;

  RxList<RestaurantReviewModel> listOfReviews=<RestaurantReviewModel>[].obs;

  RxBool isLoad=true.obs;

  //RxString categoryTitle=''.obs,categoryDesc=''.obs;

  double maxHeaderHeight = 260;
  late ScrollController scrollController;
  final ValueNotifier<double> opacity = ValueNotifier(0);

  late AutoScrollController autoScrollController;


  scrollListener() {
    if (maxHeaderHeight > scrollController.offset && scrollController.offset > 1) {
      opacity.value = 1 - scrollController.offset / maxHeaderHeight;
    } else if (scrollController.offset > maxHeaderHeight && opacity.value != 1) {
      opacity.value = 0;
    } else if (scrollController.offset < 0 && opacity.value != 0) {
      opacity.value = 1;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.value.dispose();
    autoScrollController.dispose();
    super.dispose();
  }


  @override
  void onInit() {
    scrollController = ScrollController();
    autoScrollController = AutoScrollController();
    scrollController.addListener(scrollListener);
    restaurantModel=Get.arguments[0];
    status.value=Get.arguments[1];
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      getRestaurantMenuData();
      getCartData();
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      getRestaurantMenuData();
      getCartData();
    }
  }

  Future<void> getRestaurantMenuData() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getRestaurantMenuModel=await restaurantService.getRestaurantMenuData(restaurantName: restaurantModel.slug, restaurantCode: restaurantModel.code, deviceUniqueId: deviceToken.value);
    listOfReviews.value=getRestaurantMenuModel.listOfRestaurantReview;
    if(getRestaurantMenuModel.listOfCategoryModel.isNotEmpty){
      for(CategoryModel item in getRestaurantMenuModel.listOfCategoryModel){
        listOfCategoryModel.add(CategoryModel(id: item.id, title: item.title, code: item.code, description: item.description));
      }
    }

    tabController=TabController(length: listOfCategoryModel.length, vsync: this).obs;
    isLoad.value=false;

    listOfRestaurantMenuModel.value=getRestaurantMenuModel.listOfMenuModel;

    for(int i=0;i<listOfRestaurantMenuModel.length;i++) {
      for (int j = 0; j < listOfRestaurantMenuModel[i].menuModelByCategory.length; j++){
        listOfRestaurantMenuModelByCategory.add(listOfRestaurantMenuModel[i].menuModelByCategory[j]);
        listOfRestaurantMenuModelByCategoryForAll.add(listOfRestaurantMenuModel[i].menuModelByCategory[j]);
      }
    }


  }

  Future<void> getCartData() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getCartModel.value=await restaurantService.getCartData(deviceTokenId: deviceToken.value,shipping: status.value);


  }


}