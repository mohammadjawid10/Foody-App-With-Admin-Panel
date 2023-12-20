import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/image_widget.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../utils/app_colors.dart';

class SupportScreen extends StatelessWidget{
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 31),
              child: Column(
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
                          child: Text('about'.tr,textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36,),
                  Text('pgaboutpara1'.tr,textAlign:TextAlign.start,style: heading1(color: AppColors.blackColor,fontSize:16),),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 82),
                            child: Text('Telephone; ',textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize:16),),
                          ),
                          Text('Email;',textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize:16),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 82),
                            child: Text('Mailing address  ;',textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize:16),),
                          ),
                        ],
                      ),
                      Image.asset(Img.get('support-image.png'),width: 148,height: 154,fit: BoxFit.fill,)
                    ],
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}