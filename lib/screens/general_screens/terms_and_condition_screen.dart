import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class TermsAndConditionScreen extends StatelessWidget{
  const TermsAndConditionScreen({super.key});

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
                          child:    Text("termsofservice".tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 86,),
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
                        Text('pgtermsnservhd1'.tr,
                          style: heading1SemiBold(fontSize: 15),
                        ),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara1sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara1sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara1sec3'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd2'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara2sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara2sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara2sec3'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd3'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara3sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd4'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara4sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd5'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara5sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara5sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara5sec3'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd6'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara6sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara6sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara6sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara6sec4'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd7'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara7sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara7sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara7sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara7sec4'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara7sec5'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd8'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara8sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara8sec2'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd9'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara9sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd10'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara10sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd11'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara11sec1'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd12'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara12sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec4'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec5'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec6'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec7'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec8'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec9'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec10'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara12sec11'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd13'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara13sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara13sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara13sec3'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd14'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara14sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara14sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara14sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara14sec4'.tr, style: heading1(fontSize: 13),),
                        const SizedBox(height: 7,),
                        Text('pgtermsnservhd15'.tr, style: heading1SemiBold(fontSize: 15),),
                        const SizedBox(height: 3,),
                        Text('pgtermsnservpara15sec1'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara15sec2'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara15sec3'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara15sec4'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara15sec5'.tr, style: heading1(fontSize: 13),),
                        Text('pgtermsnservpara15sec6'.tr, style: heading1(fontSize: 13),),

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

}