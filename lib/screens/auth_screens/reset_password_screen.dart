import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';

import '../../controller/auth_screens_controller/reset_password_screen_controller.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../utils/app_colors.dart';

class ResetPasswordScreen extends GetView<ResetPasswordScreenController>{
  const ResetPasswordScreen({super.key});

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
                  Text('Reset Password',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                  const SizedBox(height: 16,),
                  labelText(label: 'New Password'),
                  Obx(
                        ()=> CustomTextField(
                        controller: controller.passwordTEController,
                        focusNode: controller.passwordFocusNode,
                        onChanged: controller.passwordValidation,
                        showPassword: controller.obscured.value,
                        isPassword: true,
                        hintText: 'Password',
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
                  labelText(label: 'Repeated New Password'),
                  Obx(
                        ()=> CustomTextField(
                        onChanged: controller.confirmPasswordValidation,
                        controller: controller.confirmPasswordTEController,
                        focusNode: controller.confirmPasswordFocusNode,
                        showPassword: controller.obscured.value,
                        isPassword: true,
                        hintText: 'Confirm Password',
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
                      child: CustomFilledButton(onPress: (){controller.onChangePasswordTap();}, text: 'Save',backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,))
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