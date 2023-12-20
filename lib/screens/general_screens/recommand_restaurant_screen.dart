import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/general_screens_controller/recommand_restaurant_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class RecommendRestaurantScreen extends GetView<RecommendRestaurantScreenController>{
  const RecommendRestaurantScreen({super.key});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: iconWidget(img: 'back-button.png',size: 21)),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child:    Text("recommendarestaurant".tr,textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: "yourrestaurantname".tr),
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
                    padding: const EdgeInsets.only(bottom:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText(label: "yourrestaurantemail".tr),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(label: "note".tr),
                      CustomTextField(
                        controller: controller.noteTEController,
                        focusNode: controller.streetFocusNode,
                        onChanged: controller.noteValidation,
                        keyBoardType: TextInputType.text,
                      ),
                      Obx(
                            ()=> Visibility(
                          visible: controller.noteErrorVisible.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top:7),
                            child: Text(controller.noteErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomFilledButton(onPress: (){Get.back();}, text: "close".tr,backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,fontSize: 15,),
                      ),
                      SizedBox(width: 30,),
                      Expanded(
                        child: CustomFilledButton(onPress: (){controller.onSaveTap();}, text: 'save'.tr,backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,fontSize: 15,),
                      ),
                    ],
                  )
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