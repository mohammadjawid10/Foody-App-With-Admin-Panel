import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/general_screens_controller/indox_screen_controller.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class InboxScreen extends GetView<InboxScreenController>{
  const InboxScreen({super.key});

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
                          child:    Text('Inbox',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  itemDetailContainer(title: 'Sehr geehrter Kunde, sind Sie mit liefermars zufrieden', description: 'Ihre Bestellung NQC3UHE wurde erfolgreich zugestellt.Wir sind Ihnen dankbar, dass Sie uns als Ihre bevorzugte Plattform'),
                  itemDetailContainer(title: 'Sehr geehrter Kunde, sind Sie mit liefermars zufrieden', description: 'Ihre Bestellung NQC3UHE wurde erfolgreich zugestellt.Wir sind Ihnen dankbar, dass Sie uns als Ihre bevorzugte Plattform'),
                  itemDetailContainer(title: 'Sehr geehrter Kunde, sind Sie mit liefermars zufrieden', description: 'Ihre Bestellung NQC3UHE wurde erfolgreich zugestellt.Wir sind Ihnen dankbar, dass Sie uns als Ihre bevorzugte Plattform'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDetailContainer({required String title,required String description }){
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.only(top: 19,left: 10,right: 10,bottom: 19),
        decoration: BoxDecoration(
            color: AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.blackColor,width: 1),
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor,
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 3.0,
                  spreadRadius: 2
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: heading1(color: AppColors.blackColor,fontSize: 12),),
            const SizedBox(height: 26),
            Text(description,style: heading1(color: AppColors.blackColor,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }

}