import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class ColophonScreen extends StatelessWidget{
  const ColophonScreen({super.key});

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
                          child: Text("impressumpagetitle".tr,textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.greyColor,
                              offset: const Offset(0.0, 5.0),
                              blurRadius: 3.0,
                              spreadRadius: 4
                          ),
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('imprsm2'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm3'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm4'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm5'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm6'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm7'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm8'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm9'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm10'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm11'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm12'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm13'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm14'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm15'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm16'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm17'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm18'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm19'.tr, style: heading1(fontSize: 13),),
                        Text('imprsm20'.tr, style: heading1(fontSize: 13),),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// "pgdataprivhd2525": "Updating and changing this data protection information",
// "pgdataprivpara26sec26": "This data protection information is current as of January 2023.",
// "pgdataprivpara27sec27"

}