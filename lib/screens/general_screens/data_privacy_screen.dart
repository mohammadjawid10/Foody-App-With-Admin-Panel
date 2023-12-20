import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class DataPrivacyScreen extends StatelessWidget{
  const DataPrivacyScreen({super.key});

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
                          child: Text("dataprivacy".tr,textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
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
                        Text('pgdataprivhd11'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara1sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd22'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara2sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara2sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara2sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara2sec4'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd33'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara3sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara3sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara3sec3'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd44'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara4sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec4'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec5'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec6'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec7'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec8'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara4sec9'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd55'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpar54sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara5sec2'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd66'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara6sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara6sec2'.tr, style: heading1(fontSize: 13),),
                        Text("pgdataprivpara6secli1".tr, style: heading1(fontSize: 13),),
                        Text("pgdataprivpara6secli2".tr, style: heading1(fontSize: 13),),
                        Text("pgdataprivpara6secli3".tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd77'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara7sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd88'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara8sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara8sec2'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd99'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara9sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd1010'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara10sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara10sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara10sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara10sec4'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd1111'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara11sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara11sec2'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd1212'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara12sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12secli1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12secli2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12secli3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12secli4'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec4'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec5'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec6'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec7'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec8'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec9'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12sec10'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12tablehd1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12tablehd2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12tablehd3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara12tabletd1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd2121'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara21sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec4'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec5'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec6'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec7'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara21sec8'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd2222'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara22sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara22sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara22sec3'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd2323'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara23sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgdataprivpara23sec2'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd2424'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgdataprivpara24sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivhd2525'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 7,),
                        Text('pgdataprivpara26sec26'.tr, style: heading1SemiBold(fontSize: 15),),


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