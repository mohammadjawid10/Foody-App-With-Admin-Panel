import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liefermars/custom_widget/custom_filled_button.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: iconWidget(img: 'back-button.png',color: AppColors.blackColor,size: 20)),
            Text('Hello!',style: GoogleFonts.notoSans(
              textStyle: const TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w700),
            ),),
            SizedBox()
          ],
        ),),
      body: SafeArea(
        child: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Img.get('splash_bg.png'),height: 329,width: 329,),
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomFilledButton(
                  backgroundColor: AppColors.redColor,
                  onPress: (){
                Get.offNamed(kLoginScreen);
              }, text: "signin".tr),
            )
          ],
        )),
      ),
    );
  }
}
