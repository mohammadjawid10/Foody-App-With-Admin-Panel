import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_icon_filled_button.dart';
import '../../controller/account_screens_controller/account_setting_screen_controller.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class AccountSettingScreen extends GetView<AccountSettingScreenController>{
  const AccountSettingScreen({super.key});

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
                          child:  Text("accountsettings".tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20,top: 77),
                    child: CustomIconFilledButton(onPress: (){
                      controller.onChangePasswordTap();
                    }, text: "changepassword".tr,backgroundColor: AppColors.textFieldBackgroundColor,height: 35,textColor: AppColors.blackColor,),
                  ),
                  CustomIconFilledButton(onPress: (){
                    controller.onDeleteTap();
                  }, text: '${"delete".tr} ${'account'.tr}',backgroundColor: AppColors.textFieldBackgroundColor,height: 35,iconData: 'delete-icon.png',iconColor: AppColors.redColor,textColor: AppColors.redColor,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}