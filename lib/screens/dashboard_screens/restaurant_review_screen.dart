import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:liefermars/model/restauant_review_model.dart';

import '../../controller/dashboard_screens_controller/restaurant_review_screen_controller.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class RestaurantReviewScreen extends GetView<RestaurantReviewScreenController>{
  const RestaurantReviewScreen({super.key});

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
              child: Obx(
                    ()=> Column(
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
                            child:    Text(controller.restName,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ),
                    for(int i=0;i<controller.listOfReview.length;i++)
                      reviewDetailContainer(restaurantReviewModel:controller.listOfReview[i]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget reviewDetailContainer({required RestaurantReviewModel restaurantReviewModel}){
    return  Padding(
      padding: const EdgeInsets.only(top: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurantReviewModel.userName,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 20),),
          Padding(
            padding: const EdgeInsets.only(top: 13,bottom: 18),
            child: Text('${restaurantReviewModel.date}    ${restaurantReviewModel.time}',style: heading1(color: AppColors.blackColor,fontSize: 15),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("quality".tr,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 15),),
              RatingBar.builder(
                initialRating: restaurantReviewModel.foodQualityRating.toDouble(),
                itemSize: 18,
                minRating: 1,
                ignoreGestures: true,
                tapOnlyMode: true,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => iconWidget(img: 'star-icon.png',size: 15,color: AppColors.redColor),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18,bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("delivery".tr,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 15),),
                RatingBar.builder(
                  itemSize: 18,
                  initialRating: restaurantReviewModel.deliveryRating.toDouble(),
                  minRating: 1,
                  ignoreGestures: true,
                  tapOnlyMode: true,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => iconWidget(img: 'star-icon.png',size: 15,color: AppColors.redColor),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.only(top: 12,left: 10,right: 10,bottom: 30),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackColor),
              color: AppColors.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child:  Text(restaurantReviewModel.content,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 12),),
          ),
        ],
      ),
    );
  }

}