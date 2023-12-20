import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:liefermars/model/addons_model.dart';
import 'package:liefermars/model/option_model.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../model/addons_list_model.dart';
import '../../model/get_load_addons_model.dart';
import '../../model/get_menu_option_model.dart';
import '../../model/menu_model_by_category.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../web_services/restaurant_service.dart';

class ProductInfoScreenController extends GetxController {
  RxBool isExtra = false.obs;

  RxInt totalCount = 1.obs;

  RxList<OptionModel> selectedValue = <OptionModel>[].obs;

  RxList<OptionModel> multiSelectedValue = <OptionModel>[].obs;

  RestaurantService restaurantService = RestaurantService();

  GetMenuOptionModel getMenuOptionModel = GetMenuOptionModel.empty();
  // (
  //   addons: [],
  //   banner: "",
  //   description: "",
  //   hPrice: "400",
  //   image: "",
  //   options: OptionsModel(
  //     optionName: "Pizza",
  //     optionItemList: [],
  //   ),
  //   price: "500",
  //   restaurant: "Kabul",
  //   title: "Code HQ",
  // );
  GetLoadAddonsModel getLoadAddonsModel = GetLoadAddonsModel.empty();

  MenuModelByCategory menuModelByCategory = MenuModelByCategory.empty();

  RxList<AddonsModel> addonsList = <AddonsModel>[].obs;

  RxList<AddonsListModel> addonsListForDropDown = <AddonsListModel>[].obs;

  RxList<AddonsListModel> addonsListForSwitch = <AddonsListModel>[].obs;

  RxInt totalItem = 3.obs;

  RxDouble totalPrice = 0.0.obs;

  RxString deviceToken = ''.obs;

  OptionItemModel selectedOptionItemModel = OptionItemModel.empty();
  RxList<OptionItemModel> listOfOptionItemModel = <OptionItemModel>[].obs;

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value = iosDeviceInfo.identifierForVendor ?? '';
      deviceToken.value =
          deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value = androidDeviceInfo.id;
      deviceToken.value =
          deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    }
  }

  @override
  void onInit() {
    menuModelByCategory = Get.arguments ?? MenuModelByCategory.empty();
    totalPrice.value = double.parse(menuModelByCategory.price);
    getMenuData();
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getMenuData() async {
    print('----------------------------->>>$listOfOptionItemModel');
    print(menuModelByCategory.id);
    getMenuOptionModel = await restaurantService.getMenuOptionData(
      menuId: menuModelByCategory.id,
    );
    print(getMenuOptionModel.toString());
    addonsList.value = getMenuOptionModel.addons;
    for (int i = 0; i < addonsList.length; i++) {
      if (addonsList[i].addonsListModel.type == 'single') {
        addonsListForDropDown.add(addonsList[i].addonsListModel);
      }
      if (addonsList[i].addonsListModel.type == 'multi') {
        addonsListForSwitch.add(addonsList[i].addonsListModel);
      }
    }

    if (getMenuOptionModel.options.optionItemList.isNotEmpty) {
      for (int i = 0;
          i < getMenuOptionModel.options.optionItemList.length;
          i++) {
        if (i == 0) {
          selectedOptionItemModel =
              getMenuOptionModel.options.optionItemList[i];
        }
      }
    }

    listOfOptionItemModel.value = getMenuOptionModel.options.optionItemList;

    print('----------------------------->>>$listOfOptionItemModel');
  }

  Future<void> onCartTap() async {
    ProgressDialog pd = ProgressDialog();
    pd.showDialog();
    if (await CommonCode().checkInternetAccess()) {
      String response = await restaurantService.addToCart(
          listOfSingleAddons: selectedValue,
          listOfMultiAddons: multiSelectedValue,
          note: '',
          quantity: totalCount.value.toString(),
          restaurantId: getMenuOptionModel.restaurant,
          menuId: menuModelByCategory.id,
          hiddenPrice: getMenuOptionModel.hPrice,
          sessionId: deviceToken.value);
      pd.dismissDialog();
      if (response == "Item add to cart successfully.") {
        pd.dismissDialog();
        Get.back(result: true);
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

  Future<void> onCartForOptionTap() async {
    ProgressDialog pd = ProgressDialog();
    pd.showDialog();
    if (await CommonCode().checkInternetAccess()) {
      String response = await restaurantService.singleAddToCart(
          listOfSingleAddons: selectedValue,
          listOfMultiAddons: multiSelectedValue,
          note: '',
          quantity: totalCount.value.toString(),
          restaurantId: getMenuOptionModel.restaurant,
          menuId: menuModelByCategory.id,
          hiddenPrice: getMenuOptionModel.hPrice,
          sessionId: deviceToken.value,
          optionId: selectedOptionItemModel.id);
      pd.dismissDialog();
      if (response == "Item add to cart successfully.") {
        pd.dismissDialog();
        Get.back(result: true);
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

  Future<void> onOptionChange(OptionItemModel optionItemModel) async {
    getLoadAddonsModel = await restaurantService.getLoadedAddons(
        menuId: menuModelByCategory.id, optionId: optionItemModel.id);
    if (getLoadAddonsModel.listOfAddons.isNotEmpty) {
      addonsListForDropDown.clear();
      addonsListForSwitch.clear();
      for (int i = 0; i < getLoadAddonsModel.listOfAddons.length; i++) {
        if (getLoadAddonsModel.listOfAddons[i].type == 'single') {
          addonsListForDropDown.add(getLoadAddonsModel.listOfAddons[i]);
        } else if (getLoadAddonsModel.listOfAddons[i].type == 'multi') {
          addonsListForSwitch.add(getLoadAddonsModel.listOfAddons[i]);
        }
      }
    }
    log(getLoadAddonsModel.toString());
  }
}
