import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:liefermars/model/get_cart_model.dart';
import '../../model/payment_model.dart';
import '../../model/user_info_model.dart';
import '../../utils/user_session_management.dart';
import '../../web_services/user_service.dart';

enum PaymentType { Cash, Paypal, Klarna,CreditCard }
class PaymentMethodScreenController extends GetxController{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Rx<PaymentType> site = PaymentType.Cash.obs;



  UserSession userSession=UserSession();

  PaymentModel paymentModel=PaymentModel(paymentId: '', paymentType: 'Cash', imagePayment: 'cash-icon.png', transactionId: '');

  GetCartModel getCartModel=GetCartModel.empty();

  RxString deviceToken=''.obs;

  UserService userService=UserService();

  Rx<UserInfoModel> userInfoModel=UserInfoModel.empty().obs;

  Future<void> getPaymentInformation() async{
    paymentModel = await userSession.getPaymentInformation();
    print(paymentModel.toString());
    if(paymentModel.paymentType==''&& paymentModel.imagePayment==''){
      paymentModel=PaymentModel(paymentId: '', paymentType: 'Cash', imagePayment: 'cash-icon.png', transactionId: '');
      site.value=PaymentType.Cash;
    }else if(paymentModel.paymentType=='Paypal'){
      site.value=PaymentType.Paypal;
    }else if(paymentModel.paymentType=='CreditCard'){
      site.value=PaymentType.CreditCard;
    }
  }


  @override
  void onInit() {
    getPaymentInformation();
    //paymentModel=PaymentModel(paymentId: '', paymentType: site.value.name, imagePayment: 'cash-icon.png', transactionId: '');
    userSession.paymentInformation(paymentModel: paymentModel);
    getCartModel=Get.arguments;
    super.onInit();
  }









}
