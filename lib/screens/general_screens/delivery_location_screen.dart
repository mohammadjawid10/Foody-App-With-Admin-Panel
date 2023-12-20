import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/general_screens_controller/delivery_location_screen_controller.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class DeliveryLocationScreen extends GetView<DeliveryLocationScreenController>{
  const DeliveryLocationScreen({super.key});

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
                          child: Text('deliverylacations'.tr,textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  locationWidget(image: 'location-img.png', name: 'Ludwigshafen am Rhein'),
                  locationWidget(image: 'location2.png', name: 'Mutterstadt'),
                  locationWidget(image: 'location3.png', name: 'Frankenthal'),
                  locationWidget(image: 'location4.png', name: 'Limburgerhof'),
                  locationWidget(image: 'location5.png', name: 'Neuhofen'),
                  locationWidget(image: 'location6.png', name: 'Schifferstadt'),
                  locationWidget(image: 'location7.png', name: 'Waldsee'),
                  locationWidget(image: 'location8.png', name: 'Dannstadt'),
                  locationWidget(image: 'location9.png', name: 'Worms'),
                  locationWidget(image: 'location10.png', name: 'Osthofen'),
                  locationWidget(image: 'location11.png', name: 'Bobenheim/ Roxheim'),
                  locationWidget(image: 'location12.png', name: 'Speyer'),
                  locationWidget(image: 'location13.png', name: 'Heidelberg'),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget locationWidget({required String image,required String name}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 52),
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 144,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: AssetImage(Img.get(image)),fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.greyColor,
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 3.0,
                      spreadRadius: 4
                  ),
                ]
            ),
          ),
          const SizedBox(height: 11,),
          Text(name,textAlign:TextAlign.center,style: headingBold(color: AppColors.blackColor,fontSize: 20),),
        ],
      ),
    );
  }

}