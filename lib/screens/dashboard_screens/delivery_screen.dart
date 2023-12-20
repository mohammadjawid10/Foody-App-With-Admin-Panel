import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/dashboard_screens_controller/delivery_screen_controller.dart';

import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../utils/app_colors.dart';

class DeliveryScreen extends GetView<DeliveryScreenController> {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: (){
        Get.back(result: true);
        return Future.value(false);
      },
      child: Scaffold(
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
                    Center(child: Text("mydeliveryaddress".tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),)),
                    Padding(
                      padding: const EdgeInsets.only(top: 56,bottom: 19),
                      child: Text("personalinformation".tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: '${"streetname".tr} and ${"housenumber".tr}'),
                        CustomTextField(
                          controller: controller.streetTEController,
                          focusNode: controller.streetFocusNode,
                          onChanged: controller.streetValidation,
                          keyBoardType: TextInputType.text,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "flooroptional".tr),
                          CustomTextField(
                            controller: controller.floorTEController,
                            focusNode: controller.floorFocusNode,
                            keyBoardType: TextInputType.name,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: "zip".tr),
                        CustomTextField(
                          controller: controller.zipTEController,
                          focusNode: controller.zipFocusNode,
                          onChanged: controller.zipValidation,
                          keyBoardType: TextInputType.number,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "city".tr),
                          CustomTextField(
                            controller: controller.cityTEController,
                            focusNode: controller.cityFocusNode,
                            onChanged: controller.cityValidation,
                            keyBoardType: TextInputType.name,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50,top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "companyoptional".tr),
                          CustomTextField(
                            controller: controller.companyTEController,
                            focusNode: controller.companyFocusNode,
                            keyBoardType: TextInputType.name,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 49),
                      child: Text("personalinformation".tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: "name".tr),
                        CustomTextField(
                          controller: controller.nameTEController,
                          focusNode: controller.nameFocusNode,
                          onChanged: controller.nameValidation,
                        ),
                        Obx(
                              ()=> Visibility(
                            visible: controller.nameErrorVisible.value,
                            child: Padding(
                              padding: const EdgeInsets.only(top:7),
                              child: Text(controller.nameErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "phone".tr),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: controller.phoneTEController,
                                focusNode: controller.phoneFocusNode,
                                keyBoardType: TextInputType.number,
                                onChanged: controller.phoneValidation,
                              ),
                              Obx(
                                    ()=> Visibility(
                                  visible: controller.phoneErrorVisible.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:7),
                                    child: Text(controller.phoneErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "email".tr),
                          CustomTextField(
                            controller: controller.emailTEController,
                            focusNode: controller.emailFocusNode,
                            onChanged: controller.emailValidation,
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.emailErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.emailErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: CustomFilledButton(onPress: (){controller.onSave();}, text: '${'save'.tr} and ${"close".tr}',backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,fontSize: 15,))

                  ],
                ),
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
