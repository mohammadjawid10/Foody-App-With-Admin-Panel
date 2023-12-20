import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/address_screens_controller/my_address_screen_controller.dart';
import 'package:liefermars/utils/app_constants.dart';

import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../utils/app_colors.dart';

class MyAddressScreen extends GetView<MyAddressScreenController>{
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Address',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                  const SizedBox(height: 16,),
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomFilledButton(onPress: (){}, text: 'New Address',backgroundColor: AppColors.redColor,width: 111,height: 45,radius: 10,fontSize: 14,)),
                  const SizedBox(height: 27,),
                  addressDetailContainer(address: 'Brandenburger Straße 11 67065 Ludwigshafen'),
                  addressDetailContainer(address: 'Brandenburger Straße 11 67065 Ludwigshafen'),
                  addressDetailContainer(address: 'Brandenburger Straße 11 67065 Ludwigshafen'),
                  addressDetailContainer(address: 'Brandenburger Straße 11 67065 Ludwigshafen'),
                  addressDetailContainer(address: 'Brandenburger Straße 11 67065 Ludwigshafen'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addressDetailContainer({required String address}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.only(top: 13,left: 10,right: 10,bottom: 13),
        decoration: BoxDecoration(
            color: AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor,
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 3.0,
                  spreadRadius: 2
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(address,style: heading1(color: AppColors.blackColor,fontSize: 12),)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: (){

                    },
                    child: Text('Delete Address',style: heading1(color: AppColors.redColor,fontSize: 10),)),
                const SizedBox(height: 5),
                GestureDetector(
                    onTap: (){
                      Get.toNamed(kEditAddressScreen);
                    },
                    child: Text('Edit Address',style: heading1(color: AppColors.redColor,fontSize: 10),)),
              ],
            )
          ],
        ),
      ),
    );
  }


}