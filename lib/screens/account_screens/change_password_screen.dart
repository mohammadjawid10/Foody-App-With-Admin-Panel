import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/account_screens_controller/change_password_screen_controller.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class ChangePasswordScreen extends GetView<ChangePasswordScreenController>{
  const ChangePasswordScreen({super.key});

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
                          child:  Text("changepassword".tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  labelText(label: "oldpassword".tr),
                  Obx(
                        ()=> CustomTextField(
                        controller: controller.oldPasswordTEController,
                        focusNode: controller.oldPasswordFocusNode,
                        onChanged: controller.oldPasswordValidation,
                        showPassword: controller.obscured.value,
                        isPassword: true,
                        hintText: "oldpassword".tr,
                        suffixIcon: GestureDetector(
                          onTap: controller.toggleObscured,
                          child: Icon(
                            controller.obscured.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 15,
                            color: AppColors.textColor,
                          ),
                        )
                    ),
                  ),
                  Obx(
                        ()=> Visibility(
                      visible: controller.oldPasswordErrorVisible.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top:7),
                        child: Text(controller.oldPasswordErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  labelText(label: "newpassword".tr),
                  Obx(
                        ()=> CustomTextField(
                        controller: controller.passwordTEController,
                        focusNode: controller.passwordFocusNode,
                        onChanged: controller.passwordValidation,
                        showPassword: controller.obscured.value,
                        isPassword: true,
                        hintText: "newpassword".tr,
                        suffixIcon: GestureDetector(
                          onTap: controller.toggleObscured,
                          child: Icon(
                            controller.obscured.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 15,
                            color: AppColors.textColor,
                          ),
                        )
                    ),
                  ),
                  Obx(
                        ()=> Visibility(
                      visible: controller.passwordErrorVisible.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top:7),
                        child: Text(controller.passwordErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  labelText(label: "repeatnewpassword".tr),
                  Obx(
                        ()=> CustomTextField(
                        onChanged: controller.confirmPasswordValidation,
                        controller: controller.confirmPasswordTEController,
                        focusNode: controller.confirmPasswordFocusNode,
                        showPassword: controller.obscured.value,
                        isPassword: true,
                        hintText: "repeatyourpassword".tr,
                        suffixIcon: GestureDetector(
                          onTap: controller.toggleObscured,
                          child: Icon(
                            controller.obscured.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 15,
                            color: AppColors.textColor,
                          ),
                        )

                    ),
                  ),
                  Obx(
                        ()=> Visibility(
                      visible: controller.confirmPasswordErrorVisible.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top:7),
                        child: Text(controller.confirmPasswordErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 55,),
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomFilledButton(onPress: (){controller.onChangePasswordTap();}, text: 'save'.tr,backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText({required String label}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(label,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 16),),
    );
  }

}