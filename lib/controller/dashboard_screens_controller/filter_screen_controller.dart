import 'package:get/get.dart';
import 'package:liefermars/controller/dashboard_screens_controller/dashboard_screen_controller.dart';
import 'package:liefermars/controller/dashboard_screens_controller/home_screen_controller.dart';
import 'package:liefermars/utils/app_constants.dart';

import 'delivery_list_screen_controller.dart';

class FilterScreenController extends GetxController {

  DeliveryListScreenController deliveryListScreenController=Get.find(tag: kDeliveryListController);
  HomeScreenController homeScreenController=Get.find(tag: kHomeController);

  DashboardScreenController dashboardScreenController=Get.find(tag: kDashBoardController);



  RxBool isRestaurantOpen = false.obs;
  RxBool isFreeDelivery = false.obs;

  RxDouble currentSliderValue = 0.0.obs;

  RxDouble rating=0.0.obs;

  void onFilterApply(){
    deliveryListScreenController.getRestaurantDataFilter(
        openNow: isRestaurantOpen.value?'1':'0',
      freeDelivery: isFreeDelivery.value?'1':'0',
      rating: rating.value.toString(),
      minimunOrder: currentSliderValue.value.toString()

    );
    homeScreenController.getRestaurantDataFilter(
        openNow: isRestaurantOpen.value?'1':'0',
        freeDelivery: isFreeDelivery.value?'1':'0',
        rating: rating.value.toString(),
        minimunOrder: currentSliderValue.value.toString()

    );
  }




}
