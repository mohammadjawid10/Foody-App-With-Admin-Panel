import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/auth_screens_controller/forget_password_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../utils/app_colors.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordScreenController>{
  const ForgetPasswordScreen({super.key});

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
                 Text('Forget Password',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                 Padding(
                   padding: const EdgeInsets.only(top: 51,bottom: 14),
                   child: Text('Email-Address',style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 15),),
                 ),
                 CustomTextField(
                   controller: controller.emailTEController,
                   focusNode: controller.emailFocusNode,
                   onChanged: controller.emailValidation,
                   hintText: 'Email',
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
                 Padding(
                   padding: const EdgeInsets.only(top: 95,bottom: 17),
                   child: CustomFilledButton(
                     onPress: (){
                       controller.onSubmitTap();
                   }, text: 'Submit',backgroundColor: AppColors.redColor,),
                 ),
               ],
             ),
           ),
         ),
       ),
     ),
   );
  }

}