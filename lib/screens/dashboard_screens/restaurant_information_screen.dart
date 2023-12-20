import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liefermars/controller/dashboard_screens_controller/restaurant_information_screen_controller.dart';

import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../utils/app_colors.dart';

class RestaurantInformationScreen extends GetView<RestaurantInformationScreenController>{
  const RestaurantInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text('Restaurant Info',textAlign:TextAlign.center,style: headingBold(color: AppColors.blackColor,fontSize: 18),)),
                  controller.getRestaurantMenuModel.restLong!=''&&controller.getRestaurantMenuModel.restLat!=''?SizedBox(
                    height: 127,
                    child: GoogleMap(
                        onMapCreated: (GoogleMapController googleMapController){
                          controller.googleMapController=googleMapController;
                          if(controller.gController.isCompleted){}else {
                            controller.gController
                                .complete(googleMapController);
                          }
                        },
                        mapType: MapType.normal,
                        markers: Set<Marker>.of(controller.markers),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(controller.getRestaurantMenuModel.restLat),double.parse(controller.getRestaurantMenuModel.restLong)),
                          zoom: 10.4746,
                        )
                    ),
                  ):const SizedBox(),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(left: 21,right: 21,top: 15),
                    child: Text(controller.getRestaurantMenuModel.restName,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),textAlign: TextAlign.center,),
                  )),
                  const SizedBox(height: 15,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                    child:  Container(
                      padding: const EdgeInsets.only(top: 13,left: 10,right: 10,bottom: 13),
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
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
                          Text('Colophon',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),),
                          Text(controller.getRestaurantMenuModel.restAddress.split(',')[0],style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 10),),
                          Text('${controller.getRestaurantMenuModel.restZip}, ${controller.getRestaurantMenuModel.restCity}',style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 10),),
                          const SizedBox(height: 8,),
                          Text('info@liefermars.de',style: bodyMediumMedium(color: AppColors.darkBlueColor,fontSize: 10)),
                          Text('support@liefermars.de',style: bodyMediumMedium(color: AppColors.darkBlueColor,fontSize: 10)),
                        ],
                      ),
                    ),),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 10),
                    child:  Container(
                      padding: const EdgeInsets.only(top: 13,left: 10,right: 10,bottom: 13),
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
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
                          Text('Delivery Cost',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),),
                          Padding(
                            padding: const EdgeInsets.only(top: 20,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Minimum Order Amount',style: heading1(color: AppColors.blackColor,fontSize: 10),),
                                Text('${controller.getRestaurantMenuModel.restaurantInfoModel.minOrderAmount} €',style: heading1(color: AppColors.blackColor,fontSize: 10),),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Costs',style: heading1(color: AppColors.blackColor,fontSize: 10),),
                              Text('${controller.getRestaurantMenuModel.restaurantInfoModel.deliveryCost} ',style: heading1(color: AppColors.blackColor,fontSize: 10),),
                            ],
                          ),
                        ],
                      ),
                    ),),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 10),
                    child:  Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(top: 27,left: 10,right: 10,bottom: 27),
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
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
                          Text('Opening Hours',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),),
                        ],
                      ),
                    ),),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 10),
                    child:  Container(
                      padding: const EdgeInsets.only(top: 13,left: 10,right: 10,bottom: 13),
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBackgroundColor,
                          borderRadius: BorderRadius.circular(15),
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
                          for(int i=0;i<controller.getRestaurantMenuModel.listOfRestTiming.length;i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.getRestaurantMenuModel.listOfRestTiming[i].day,style: heading1(color: AppColors.blackColor,fontSize: 10),),
                                Text(controller.getRestaurantMenuModel.listOfRestTiming[i].delivery,style: heading1(color: AppColors.blackColor,fontSize: 10),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: CustomFilledButton(onPress: (){Get.back();}, text: 'Close',backgroundColor: AppColors.redColor,width: 73,height: 21,radius: 15,fontSize: 13,),
                      ))
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}