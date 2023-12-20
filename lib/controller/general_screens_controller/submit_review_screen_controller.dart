import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liefermars/model/get_review_data_model.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../web_services/restaurant_service.dart';

class SubmitReviewScreenController extends GetxController{
  TextEditingController nameTEController = TextEditingController();
  TextEditingController phoneTEController = TextEditingController();
  TextEditingController commentTEController = TextEditingController();
  RxBool nameErrorVisible = RxBool(false);
  RxBool commentErrorVisible = RxBool(false);
  RxString nameErrorMsg = "".obs;
  RxString commentErrorMsg = "".obs;
  RxBool phoneErrorVisible = RxBool(false);
  RxString phoneErrorMsg = "".obs;

  String hashKey='',orderId='';

  String quality='1',deliveryQ='1';
  
  Rx<GetReviewDataModel> getReviewDataModel=GetReviewDataModel.empty().obs;

  RxList<DeliveryTimeModel> listOfDeliveryTime=<DeliveryTimeModel>[].obs;
  RxList<ShowNamesModel> listOfShowNames=<ShowNamesModel>[].obs;

  Rx<ShowNamesModel> selectedShowName=ShowNamesModel.empty().obs;
  Rx<DeliveryTimeModel> selectedDeliveryTime=DeliveryTimeModel.empty().obs;


  FocusNode nameFocusNode = FocusNode(),
  commentFocusNode = FocusNode(),
      phoneFocusNode = FocusNode();

  RxString deviceToken=''.obs;

  RestaurantService restaurantService=RestaurantService();

  Future<void> getDeviceTokenToSendNotification() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceToken.value= iosDeviceInfo.identifierForVendor??'';
      deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
      getReviewData();
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceToken.value= androidDeviceInfo.id;
      deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
      getReviewData();
    }
  }

  @override

  @override
  void onInit() {
   hashKey=Get.arguments[0];
   orderId=Get.arguments[1];
   getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getReviewData() async{
    getReviewDataModel.value=await restaurantService.getReviewData(deviceTokenId: deviceToken.value);

    if(getReviewDataModel.value.deliveryTime.isNotEmpty){
      listOfDeliveryTime.clear();
      selectedDeliveryTime.value = DeliveryTimeModel(time: 'Please Select Time', value: '0');
      listOfDeliveryTime.add(selectedDeliveryTime.value);
      for(DeliveryTimeModel item in getReviewDataModel.value.deliveryTime){
        listOfDeliveryTime.add(DeliveryTimeModel(time: item.time, value: item.value));
      }
    }

    if(getReviewDataModel.value.showNames.isNotEmpty){
      listOfShowNames.clear();
      selectedShowName.value = ShowNamesModel(name: 'Please Select Name', value: '');
      listOfShowNames.add(selectedShowName.value);
      for(ShowNamesModel item in getReviewDataModel.value.showNames){
        listOfShowNames.add(ShowNamesModel(name: item.name, value: item.value));
      }
    }


  }


  bool timeValidation(String value) {
    if (value.trim() == "0") {
      nameErrorVisible.value = true;
      nameErrorMsg.value = "required!";
    }
    else {
      nameErrorVisible.value = false;
      nameErrorMsg.value = "";
    }
    return nameErrorVisible.value;
  }

  bool commentValidation(String value) {
    if (value.trim() == "") {
      commentErrorVisible.value = true;
      commentErrorMsg.value = "required!";
    } else if (value.trim().length < 3 ||
        value.isEmpty) {
      commentErrorVisible.value = true;
      commentErrorMsg.value = "Invalid!";
    }
    else {
      commentErrorVisible.value = false;
      commentErrorMsg.value = "";
    }
    return commentErrorVisible.value;
  }

  bool nameValidation(String value) {
    if (value.trim() == "") {
      phoneErrorVisible.value = true;
      phoneErrorMsg.value = "required!";
    }
    else {
      phoneErrorVisible.value = false;
      phoneErrorMsg.value = "";
    }
    return phoneErrorVisible.value;
  }



  void removeAFieldsFocus() {
    if (nameFocusNode.hasFocus) {
      nameFocusNode.unfocus();
    } else if (phoneFocusNode.hasFocus) {
      phoneFocusNode.unfocus();
    }else if (commentFocusNode.hasFocus) {
      commentFocusNode.unfocus();
    }
  }

  Future<void> onReviewTap() async{
    bool isAllDataValid = false;
    isAllDataValid = ! timeValidation(selectedDeliveryTime.value.value);
    isAllDataValid = !nameValidation(selectedShowName.value.value) && isAllDataValid;
    if(isAllDataValid){
          ProgressDialog pd = ProgressDialog();
    pd.showDialog();
    if(await CommonCode().checkInternetAccess()) {
      String response = await restaurantService.submitRating(deviceToken: deviceToken.value, quanlity: quality, comment: commentTEController.text, hashKey: hashKey, deliveryQ: deliveryQ, name: nameTEController.text, deliveryTime: phoneTEController.text, orderId: orderId);
      pd.dismissDialog();
      if (response=='Your Review and Rating Successfully Submitted.') {
        pd.dismissDialog();
        Get.back();
        Get.back();
      } else {
        pd.dismissDialog();
        CustomDialogs().showMessageDialog(
            title: "Alert", description: response, type: DialogType.ERROR);
      }
    } else{
      pd.dismissDialog();
      CustomDialogs().showMessageDialog(title: 'Alert',
          description: kInternetMsg,
          type: DialogType.ERROR);
    }
    }

  }
}