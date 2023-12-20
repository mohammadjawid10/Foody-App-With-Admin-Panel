import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/auth_screens_controller/login_sreen_controller.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/custom_widget/custom_textfield.dart';
import 'package:liefermars/utils/app_colors.dart';
import 'package:liefermars/utils/app_constants.dart';

import '../../custom_widget/custom_normal_appbar.dart';
import '../../custom_widget/image_widget.dart';

class LoginScreen extends GetView<LoginScreenController>{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: (){
       return controller.onWillPop();

     },
     child: NotificationListener(
       onNotification: (notificationInfo){
         if(notificationInfo is UserScrollNotification){
           FocusScopeNode currentFocus = FocusScope.of(context);
           if (!currentFocus.hasPrimaryFocus) {
             currentFocus.unfocus();
           }
         }
         return true;

       },
       child: GestureDetector(
         onTap: (){
           controller.removeAFieldsFocus();
         },
         child: Scaffold(
           backgroundColor: AppColors.whiteColor,
           appBar:  PreferredSize(
             preferredSize:const Size.fromHeight(50),
             child: CustomNormalAppbar(title: "signin".tr)),
           body: _getBody(),
         ),
       ),
     ),
   );
  }

  Widget _getBody(){
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.emailTEController,
                focusNode: controller.emailFocusNode,
                onChanged: controller.emailValidation,
                hintText: "email".tr,
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
                padding: const EdgeInsets.only(top: 18,),
                child: Obx(
                      ()=> CustomTextField(
                      controller: controller.passwordTEController,
                      focusNode: controller.passwordFocusNode,
                      onChanged: controller.passwordValidation,
                      showPassword: controller.obscured.value,
                      isPassword: true,
                      hintText: "enterpassword".tr,
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Align(alignment:Alignment.topRight,
                    child: GestureDetector(
                        onTap:(){
                          Get.toNamed(kForgetPasswordScreen);
                          },
                        child: Text('${"forgetpassword".tr}?',
                          style: heading1(color: AppColors.darkBlueColor.withOpacity(0.5),fontSize: 16),
                        )
                    )
                ),
              ),
              const SizedBox(height: 64,),
              Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: CustomFilledButton(onPress: (){
                  controller.onLoginTap();
                }, text:"signin".tr,backgroundColor: AppColors.redColor,),
              ),
              Center(child: needAnAccount()),
              SizedBox(height: 95,),
              Center(child: Text("or".tr.toUpperCase(),style: heading1(color: AppColors.blackColor,fontSize: 16),)),
              optionTextWidget(),
              socialMediaIconsRowWidget(),


            ],
          ),
        ),
      ),
    );
  }

  Widget optionTextWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 30,top: 17,bottom: 40),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              height: 2,
              color: AppColors.textColor,
            ),
          ),
          Text(' ${"signin".tr} using ',style: heading1(color: AppColors.blackColor,fontSize: 18.4),),
          Flexible(
            child: Container(
              height: 2,
              color: AppColors.textColor,


            ),
          ),
        ],
      ),
    );
  }

  Widget socialMediaIconsRowWidget(){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*socialMediaIconWidget(image: "apple-icon.png",onPressed: (){}),
        const SizedBox(width: 17),*/
        socialMediaIconWidget(image: "google-icon.png",onPressed: (){controller.onGoogleSignIn();}),
        const SizedBox(width: 17),
        socialMediaIconWidget(image: "facebook-icon.png",onPressed: (){
          controller.fbLoginTap();
        }),
        const SizedBox(width: 17),
        if(Platform.isIOS)
        socialMediaIconWidget(image: "apple-icon.png",onPressed: (){
          controller.appleLoginTap();
        }),
      ],
    );
  }

  Widget socialMediaIconWidget({onPressed, required String image}) {
    return Container(
      height: 54,
      width: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(54),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: iconWidget(img: image),
        ),
      ),
    );
  }

  Widget needAnAccount(){
    return RichText(
      text: TextSpan(
        text: 'Need An Account?    ',
        style: heading1(color: AppColors.blackColor,fontSize: 18),
        children:  <TextSpan>[
          TextSpan(text: "signup".tr, style: heading1SemiBold(color: AppColors.blackColor,fontSize: 18),recognizer: TapGestureRecognizer()..onTap=()=>controller.onSignUpTap()),
        ],
      ),
    );
  }

}