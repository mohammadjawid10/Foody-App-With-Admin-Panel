import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/account_screens_controller/account_screen_controller.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';
import 'package:liefermars/custom_widget/image_widget.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../utils/app_colors.dart';

class AccountScreen extends GetView<AccountScreenController>{
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 60),
            child: Column(
              children: [
                const Spacer(),
                Text('Liefermars is requesting access to:',style: headingBold(color: AppColors.blackColor,fontSize: 16),),
                Text('Your name and profile picture and email address.',style: headingBold(color: AppColors.blackColor,fontSize: 14),),
               const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Edit access',style: headingBold(color: AppColors.darkBlueColor,fontSize: 13),),
                    const SizedBox(width: 7,),
                    iconWidget(img: 'edit-access-icon.png',size: 14)
                  ],
                ),
                const Spacer(),
                CustomFilledButton(onPress: (){}, text: 'Contineu as Sefik',backgroundColor: AppColors.darkBlueColor,),
                Padding(
                  padding: const EdgeInsets.only(top: 11,bottom: 40),
                  child: CustomFilledButton(onPress: (){}, text: 'Cancel',backgroundColor: AppColors.textFieldBackgroundColor,textColor: AppColors.blackColor,),
                ),
                Text('By continuing, Liefermars will receive ongoing access to the information you share and Facebook will record when Liefermars accesses it. Learn more about this sharing and the settings you have. Liefermars Privacy Policy and Terms',style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 8),),
              ],
            ),
          ),
        ),
      ),
    );
  }

}