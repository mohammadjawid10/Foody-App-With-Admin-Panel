import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/order_screens_controller/payment_method_screen_controller.dart';
import '../../custom_widget/custom_navigation_drawer.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../model/payment_model.dart';
import '../../utils/app_colors.dart';

class PaymentMethodScreen extends GetView<PaymentMethodScreenController>{
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: (){
        Get.back(result: true);
        return Future.value(false);
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back(result: true);
                          },
                          child: iconWidget(img: 'back-button.png',size: 21)),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text('Select payment method',textAlign:TextAlign.center,style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),
                          ),),
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            controller.scaffoldKey.currentState!.openDrawer();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: iconWidget(img: 'menu-icon.png',size: 30))
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: payCategory(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        drawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Widget payCategory(){
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            controller.site.value = PaymentType.Cash;
            controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'cash-icon.png', transactionId: '');
            controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
            Get.back(result: true);
          },
          child: ListTile(
            title: Row(
              children: [
                iconWidget(img: 'cash-icon.png',size: 30),
               const SizedBox(width: 30,),
               Text('Cash',style: heading1(fontSize: 14),),
                const Spacer(),
                Obx(
                  ()=> Radio(
                    value: PaymentType.Cash,
                    groupValue: controller.site.value,
                    activeColor: AppColors.redColor,
                    onChanged: (PaymentType? value) {
                      controller.site.value = PaymentType.Cash;
                      controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'cash-icon.png', transactionId: '');
                      controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
                      Get.back(result: true);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            controller.site.value = PaymentType.Paypal;
            controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'paypal-icon.png', transactionId: '');
            controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
            Get.back(result: true);
          },
          child: ListTile(
            title: Row(
              children: [
                iconWidget(img: 'paypal-icon.png',size: 30),
                const SizedBox(width: 30,),
                Text('Paypal',style: heading1(fontSize: 14),),
                const Spacer(),
                Obx(
                  ()=> Radio(
                    value: PaymentType.Paypal,
                    activeColor: AppColors.redColor,
                    groupValue: controller.site.value,
                    onChanged: (PaymentType? value) async{
                      controller.site.value = PaymentType.Paypal;
                      controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'paypal-icon.png', transactionId: '');
                      controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
                      Get.back(result: true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        /*ListTile(
          title: Row(
            children: [
              iconWidget(img: 'klawa-icon.png',size: 30),
              const SizedBox(width: 30,),
              Text('Klarna',style: heading1(fontSize: 14),),
              const Spacer(),
              Obx(
                ()=> Radio(
                  value: PaymentType.Klarna,
                  groupValue: controller.site.value,
                  activeColor: AppColors.redColor,
                  onChanged: (PaymentType? value) {
                    controller.site.value = value!;
                    controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'klawa-icon.png', transactionId: '');
                    controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
                  },
                ),
              ),
            ],
          ),
        ),*/
        GestureDetector(
          onTap: (){
            controller.site.value = PaymentType.CreditCard;
            controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'visa-icon.png', transactionId: '');
            controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
            Get.back(result: true);
          },
          child: ListTile(
            title: Row(
              children: [
                iconWidget(img: 'visa-icon.png',size: 30),
                const SizedBox(width: 30,),
                Text('Credit Card',style: heading1(fontSize: 14),),
                const Spacer(),
                Obx(
                  ()=> Radio(
                    value: PaymentType.CreditCard,
                    groupValue: controller.site.value,
                    activeColor: AppColors.redColor,
                    onChanged: (PaymentType? value) {
                      controller.site.value = PaymentType.CreditCard;
                      controller.paymentModel=PaymentModel(paymentId: '', paymentType: controller.site.value.name, imagePayment: 'visa-icon.png', transactionId: '');
                      controller.userSession.paymentInformation(paymentModel: controller.paymentModel);
                      Get.back(result: true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}