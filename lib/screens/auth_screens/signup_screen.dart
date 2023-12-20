import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/auth_screens_controller/signup_screen_controller.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/custom_widget/custom_textfield.dart';
import 'package:liefermars/utils/app_colors.dart';
import '../../custom_widget/custom_normal_appbar.dart';
import '../../custom_widget/image_widget.dart';

class SignUpScreen extends GetView<SignUpScreenController>{
  const SignUpScreen({super.key});

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
            appBar: PreferredSize(
                preferredSize:const Size.fromHeight(50),
                child: CustomNormalAppbar(title: "signup".tr)),
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
                controller: controller.userNameTEController,
                focusNode: controller.userNameFocusNode,
                onChanged: controller.usernameValidation,
                hintText: 'Name',
              ),
              Obx(
                    ()=> Visibility(
                  visible: controller.userNameErrorVisible.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top:7),
                    child: Text(controller.userNameErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CustomTextField(
                  controller: controller.emailTEController,
                  focusNode: controller.emailFocusNode,
                  onChanged: controller.emailValidation,
                  hintText: 'Email Id or Username',
                ),
              ),
              Obx(
                    ()=> Visibility(
                  visible: controller.emailErrorVisible.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(controller.emailErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
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
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Obx(
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
              Padding(
                padding: const EdgeInsets.only(top:17,bottom:37),
                child: updateCheckBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 19),
                child: CustomFilledButton(onPress: (){
                  controller.registerButtonPressed();
                }, text: "signup".tr,backgroundColor: AppColors.redColor,),
              ),
              const SizedBox(height: 30,),
              termsAndPrivacyText(),
              // const SizedBox(height: 10,),
              // Center(child: Text("or".tr.toUpperCase(),style: heading1(color: AppColors.blackColor,fontSize: 16),)),
              // optionTextWidget(),
              // socialMediaIconsRowWidget(),


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
          Text(' ${"signup".tr} using ',style: heading1(color: AppColors.blackColor,fontSize: 18.4,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
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
       /* socialMediaIconWidget(image: "apple-icon.png",onPressed: (){}),
        const SizedBox(width: 17),*/
        socialMediaIconWidget(image: "google-icon.png",onPressed: (){controller.onGoogleSignIn();}),
        const SizedBox(width: 17),
        socialMediaIconWidget(image: "facebook-icon.png",onPressed: (){
          controller.fbLoginTap();
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

  Widget termsAndPrivacyText(){
    return RichText(
      text: TextSpan(
        text: 'By tapping ”Sign Up”or”Continue with Google, Facebook, or Apple,”you agree to Liefermars.de',
        style: heading1(color: AppColors.blackColor,fontSize: 10),
        children:  <TextSpan>[
          TextSpan(text: ' Terms and Conditions', style: heading1SemiBold(color: AppColors.darkBlueColor,fontSize: 10),),
          TextSpan(text: ' and ', style: heading1SemiBold(color: AppColors.blackColor,fontSize: 10),),
          TextSpan(text: 'Privacy Police. ', style: heading1SemiBold(color: AppColors.darkBlueColor,fontSize: 10),),
        ],
      ),
    );
  }

  Widget updateCheckBox(){
    return GestureDetector(
      onTap: (){
        controller.isRememberMeTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(()=> Icon(controller.isRemember.value?Icons.check_box_sharp:Icons.check_box_outline_blank,color: AppColors.blackColor,size: 15)),
          const SizedBox(width: 3),
          Expanded(child: Text('Yes, I want to receive discounts, loyalty offers and other updates.',style: heading1(color: AppColors.blackColor,fontSize: 13),)),
        ],),
    );
  }



}