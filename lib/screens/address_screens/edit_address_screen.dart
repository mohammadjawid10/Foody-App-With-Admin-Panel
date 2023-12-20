import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/address_screens_controller/edit_address_screen_controller.dart';
import 'package:liefermars/custom_widget/custom_textfield.dart';

import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../utils/app_colors.dart';

class EditAddressScreen extends GetView<EditAddressScreenController>{
  const EditAddressScreen({super.key});

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
                  Text('Edit My Address',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                  const SizedBox(height: 65),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: 'Street'),
                          CustomTextField(
                            controller: controller.streetTEController,
                            focusNode: controller.streetFocusNode,
                            onChanged: controller.streetValidation,
                            width: Get.width/1.6,
                            hintText: 'Street',
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.streetErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.streetErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 17,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: 'House #'),
                          CustomTextField(
                            controller: controller.houseTEController,
                            focusNode: controller.houseFocusNode,
                            onChanged: controller.houseValidation,
                            width: Get.width/5,
                            hintText: '1234',
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.houseErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.houseErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: 'Apartment(Optional)'),
                        CustomTextField(
                          controller: controller.apartmentTEController,
                          focusNode: controller.apartmentFocusNode,
                          hintText: 'Apartment or suite',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: 'City'),
                          CustomTextField(
                            controller: controller.cityTEController,
                            focusNode: controller.cityFocusNode,
                            width: Get.width/1.6,
                            onChanged: controller.cityValidation,
                            hintText: 'City',
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.cityErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.cityErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 17,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: 'Zip'),
                          CustomTextField(
                            controller: controller.zipTEController,
                            focusNode: controller.zipFocusNode,
                            onChanged: controller.zipValidation,
                            width: Get.width/5,
                            hintText: '1234',
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.zipErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.zipErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: 'Floor (Optional)'),
                        CustomTextField(
                          controller: controller.floorTEController,
                          focusNode: controller.floorFocusNode,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: 'Company(Optional)'),
                        CustomTextField(
                          controller: controller.companyTEController,
                          focusNode: controller.companyFocusNode,
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomFilledButton(onPress: (){}, text: 'Save and Close',backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,fontSize: 15,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText({required String label}){
    return Text(label,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 16),);
  }

}