import 'dart:convert';
import 'dart:io';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:liefermars/model/get_cart_model.dart';
import 'package:liefermars/utils/user_session_management.dart';
import 'package:liefermars/web_services/restaurant_service.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_proggress_dialog.dart';
import '../../model/address_model.dart';
import '../../model/checkout_model.dart';
import '../../model/payment_model.dart';
import '../../model/time_model.dart';
import '../../model/user_info_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_code.dart';
import '../../web_services/user_service.dart';

class CheckOutScreenController extends GetxController{
  TextEditingController notesTEController=TextEditingController();
  RxString status='Delivery'.obs;

  double totalAmount=0;

  UserSession userSession=UserSession();

  Rx<AddressModel> addressModel=AddressModel.empty().obs;

  RestaurantService restaurantService =RestaurantService();

  RxString deviceToken=''.obs;

  Rx<GetTimeModel> timeModel=GetTimeModel.empty().obs;

  RxList<TimeModel> listOfTimeModel=<TimeModel>[].obs;

  Rx<TimeModel> selectedDeliveryTime=TimeModel.empty().obs;

  GetCartModel getCartModel=GetCartModel.empty();

 Rx<PaymentModel> paymentModel=PaymentModel.empty().obs;

  Map<String, dynamic> paymentIntentData={};

  Rx<UserInfoModel> userInfoModel=UserInfoModel.empty().obs;

  UserService userService=UserService();

  RxString errorMessage=''.obs;
  RxBool isErrorMsg=false.obs;





  Future<void> getTime() async{
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    timeModel.value=await restaurantService.getTime(deviceToken: deviceToken.value);
    listOfTimeModel.clear();
    selectedDeliveryTime.value = TimeModel(time: 'ASAP');
    listOfTimeModel.add(selectedDeliveryTime.value);
    if(timeModel.value.time.isNotEmpty){
      for(TimeModel item in timeModel.value.time){
        listOfTimeModel.add(TimeModel(time: item.time));
      }
    }


  }

  @override
  void onInit() {
    getCartModel=Get.arguments[0]??GetCartModel.empty();
    status.value=Get.arguments[1];
    totalAmount=getCartModel.cartTotalAmount;
   getUserAddressInformation();
   getPaymentInformation();
   getDeviceTokenToSendNotification();
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceToken.value= iosDeviceInfo.identifierForVendor??'';
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getTime();
    getUserData();
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    deviceToken.value= androidDeviceInfo.id;
    deviceToken.value=deviceToken.value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    getTime();
    getUserData();
  }
}

  bool nameEmailPhoneValidation() {
    if (addressModel.value.yourEmail.trim() == "") {
      isErrorMsg.value = true;
      errorMessage.value = "Email is required!";
    } else if (addressModel.value.yourPhone.trim() == "") {
      isErrorMsg.value = true;
      errorMessage.value = "PhoneNumber is required!";
    } else if (addressModel.value.clientName.trim() == "") {
      isErrorMsg.value = true;
      errorMessage.value = "Name is required!";
    }  else {
      isErrorMsg.value = false;
      errorMessage.value = "";
    }
    return isErrorMsg.value;
  }

  Future<void> getUserData() async{
    userInfoModel.value=await userService.getUserData(deviceToken: deviceToken.value);
  }

  Future<void> getUserAddressInformation() async{
    if(status.value=='Delivery') {
      addressModel.value = await userSession.getAddressInformation();
    }else{
      addressModel.value = await userSession.getAddressInformationForPick();
    }
}

  Future<void> getPaymentInformation() async{
      paymentModel.value = await userSession.getPaymentInformation();
      if(paymentModel.value.paymentType==''&& paymentModel.value.imagePayment==''){
        paymentModel.value=PaymentModel(paymentId: '', paymentType: 'Cash', imagePayment: 'cash-icon.png', transactionId: '');
      }
  }


  Future<void> onCheckOutClick() async{
    ProgressDialog pd = ProgressDialog();
    if(await CommonCode().checkInternetAccess()) {
      CheckOutModel response=CheckOutModel();
      if(paymentModel.value.paymentType=='CreditCard'){
        await makePayment();
      }if(paymentModel.value.paymentType=='Paypal'){
        onPaypal();
      }else if(paymentModel.value.paymentType=='Cash'){
        pd.showDialog();
        response = await restaurantService.checkOut(addressModel: addressModel.value, deviceToken: deviceToken.value, notes: notesTEController.text, deliveryTime: selectedDeliveryTime.value.time, shipping: status.value.toLowerCase(), paymentType: 'cod');
        pd.dismissDialog();
        if (response.statusDescription=='success') {
          Get.offAllNamed(kPaymentDoneScreen,arguments: response.orderNumber);
        } else {
          pd.dismissDialog();
          CustomDialogs().showMessageDialog(
              title: "Alert", description: response.statusDescription, type: DialogType.ERROR);
        }
      }

    } else{
      pd.dismissDialog();
      CustomDialogs().showMessageDialog(title: 'Alert',
          description: kInternetMsg,
          type: DialogType.ERROR);
    }
  }

  Future<void> afterCheckOutForStripe() async{
    ProgressDialog pd = ProgressDialog();
    CheckOutModel response=CheckOutModel();
    response = await restaurantService.checkOutStripe(addressModel: addressModel.value, deviceToken: deviceToken.value, notes: notesTEController.text, deliveryTime: selectedDeliveryTime.value.time, shipping: status.value.toLowerCase(), paymentType: 'stripe',requestId: paymentModel.value.paymentId);
    pd.dismissDialog();
    if (response.statusDescription=='success') {
      Get.offAllNamed(kPaymentDoneScreen,arguments: response.orderNumber);
    } else {
      pd.dismissDialog();
      CustomDialogs().showMessageDialog(
          title: "Alert", description: response.statusDescription, type: DialogType.ERROR);
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(getCartModel.cartTotalAmount.toStringAsFixed(0), 'EUR')??{}; //json.decode(response.body);
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
              paymentIntentData['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: userInfoModel.value.firstname)
      )
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e) {
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData['client_secret'],
          confirmPayment: true,
        )
      )
          .then((newValue) {
        if(paymentIntentData['id'].toString()!='' || paymentIntentData['id']!=null){
          paymentModel.value.paymentId=paymentIntentData['id'].toString();
        }
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));
         afterCheckOutForStripe();

       paymentIntentData = {};
      }).onError((error, stackTrace) {
      });
    } on StripeException {
      showDialog(
          context: Get.context!,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount':calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51MuMjcHK08LMGtNrBP8BxbHfGYuNkt0nvu48YZb7IGIHJsiZCWvYM1NHt2CNyFOIm2Km1UyKk4jaIou7tLwceoMJ00hd2aiy4I',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount))*100;
    return a.toString();
  }


  void onPaypal() {
    Get.to(UsePaypal(
        sandboxMode: true,
        clientId:
        "AdySXcF2yqaDyiC4KNfPXlMDyYw3Ql2sjkqQxXtbA2k856og08JS4PqeNiOqsYaHg1gZl3iPM5C--e_e",
        secretKey:
        "EFDr4OKX2yQOMImRSG-bnLyINjpmSenq51cGRzrYrq-hqbNUAq7Axc_4sEjzwYVN2ggvMiZK3QDSEVSK",
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions:  [
          {
            "amount": {
              "total": getCartModel.cartTotalAmount.toString(),
              "currency": "EUR",
              "details": {
                "subtotal": getCartModel.totalPurchase.toString(),
                "shipping": getCartModel.deliveryFee.toString(),
                "shipping_discount": 0
              }
            },
            "description":
            "The payment For purchase.",
            "item_list": {
              "items": [
                for(int i=0;i<getCartModel.items.length;i++)
                  {
                    "name": getCartModel.items[i].name.toString(),
                    "quantity": int.parse(getCartModel.items[i].quantity.value),
                    "price": getCartModel.items[i].price.toString(),
                    "currency": "EUR"
                  }
              ],

              // shipping address is not required though
              "shipping_address": {
                "recipient_name": userInfoModel.value.firstname,
                "line1": addressModel.value.street,
                "line2": "",
                "postal_code": addressModel.value.youZip,
                "city": addressModel.value.yourCity,
                "country_code": "DE",
                "phone": addressModel.value.yourPhone,
              },
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          paymentModel.value=PaymentModel(paymentId: '', paymentType: '', imagePayment: 'paypal-icon.png', transactionId:params['data']['transactions'][0]['related_resources'][0]['sale']['id']);
          afterCheckOutForPaypal();
        },
        onError: (error) {
        },
        onCancel: (params) {
        }));
  }

  Future<void> afterCheckOutForPaypal() async{
    ProgressDialog pd = ProgressDialog();
    CheckOutModel response=CheckOutModel();
    response = await restaurantService.checkOutStripe(addressModel: addressModel.value, deviceToken: deviceToken.value, notes: notesTEController.text, deliveryTime: selectedDeliveryTime.value.time, shipping: status.value.toLowerCase(), paymentType: 'paypal',requestId: paymentModel.value.transactionId);
    pd.dismissDialog();
    if (response.statusDescription=='success') {
      Get.offAllNamed(kPaymentDoneScreen,arguments: response.orderNumber);
    } else {
      pd.dismissDialog();
      CustomDialogs().showMessageDialog(
          title: "Alert", description: response.statusDescription, type: DialogType.ERROR);
    }
  }


}