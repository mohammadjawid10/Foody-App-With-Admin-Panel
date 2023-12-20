import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/app_colors.dart';
import 'package:liefermars/utils/app_constants.dart';

import '../../controller/order_screens_controller/payment_done_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';

class PaymentDoneScreen extends GetView<PaymentDoneScreenController>{


  const PaymentDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: (){
        Get.offNamed(kDashboardScreen);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 60),
              child: Column(
                children: [
                  Align(alignment:Alignment.topLeft,child: GestureDetector(
                      onTap: (){
                        Get.offNamed(kDashboardScreen);
                      },
                      child: iconWidget(img: 'back-button.png',color: AppColors.blackColor))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 31),
                    child: Text('Order submitted',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                  ),
                  iconWidget(img: 'confirm-icon.png',size: 70),
                  Padding(
                    padding: const EdgeInsets.only(top:55,bottom: 9),
                    child: Text('Order #${controller.orderNumber}',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 15),),
                  ),
                 /* SizedBox(height: 15,),
                  CustomFilledButton(onPress: (){}, text: 'View Order',backgroundColor: AppColors.redColor,height: 50,radius: 10,fontSize: 20,),*/
                  const Spacer(),
                  CustomFilledButton(onPress: (){}, text: 'Thank You For Order',backgroundColor: AppColors.redColor,height: 50,radius: 10,fontSize: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}