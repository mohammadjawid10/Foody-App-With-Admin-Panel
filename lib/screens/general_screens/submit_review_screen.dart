import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../controller/general_screens_controller/submit_review_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../model/get_review_data_model.dart';
import '../../utils/app_colors.dart';

class SubmitReviewScreen extends GetView<SubmitReviewScreenController>{
  const SubmitReviewScreen({super.key});

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

                  Text('Submit Reviews',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                  reviewDetailContainer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget reviewDetailContainer(){
    return  Padding(
      padding: const EdgeInsets.only(top: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dropDownForDeliveryTime(),
              Obx(
                    ()=> Visibility(
                  visible: controller.nameErrorVisible.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top:7),
                    child: Text(controller.nameErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dropDownForName(),
                    Obx(
                          ()=> Visibility(
                        visible: controller.phoneErrorVisible.value,
                        child: Padding(
                          padding: const EdgeInsets.only(top:7),
                          child: Text(controller.phoneErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quality',style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 15),),
              RatingBar.builder(
                initialRating: double.parse(controller.quality),
                itemSize: 18,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => iconWidget(img: 'star-icon.png',size: 15,color: AppColors.redColor),
                onRatingUpdate: (rating) {
                  controller.quality=rating.toString();
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18,bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery',style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 15),),
                RatingBar.builder(
                  itemSize: 18,
                  initialRating:double.parse(controller.deliveryQ),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => iconWidget(img: 'star-icon.png',size: 15,color: AppColors.redColor),
                  onRatingUpdate: (rating) {
                    controller.deliveryQ=rating.toString();
                  },
                )
              ],
            ),
          ),
          Container(
            height: 78,
            width: Get.width,
            decoration: BoxDecoration(
                color: AppColors.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.greyColor,
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 3.0,
                      spreadRadius: 4
                  ),
                ]
            ),
            padding: const EdgeInsets.all(8),
            child:  TextField(
            controller: controller.commentTEController,
              onChanged: controller.commentValidation,
              focusNode: controller.commentFocusNode,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                counterText: "",
                hintStyle: heading1(color: AppColors.textColor,fontSize: 14),
                hintText: 'Write your comment',
                fillColor: AppColors.textFieldBackgroundColor,
              ),

            ),
          ),
          Obx(
                ()=> Visibility(
              visible: controller.commentErrorVisible.value,
              child: Padding(
                padding: const EdgeInsets.only(top:7),
                child: Text(controller.commentErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
              ),
            ),
          ),
          const SizedBox(height: 43,),
          Align(
              alignment: Alignment.topRight,
              child: CustomFilledButton(onPress: (){controller.onReviewTap();}, text: 'Submit',backgroundColor: AppColors.redColor,width: 103,height: 37,radius: 10,fontSize: 15,)),

        ],
      ),
    );
  }

  Widget dropDownForDeliveryTime(){
    return Obx(
          ()=> Container(
        width: Get.width,
        height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.blackColor,width: 1),
              color: AppColors.textFieldBackgroundColor,
            ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DeliveryTimeModel>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            value: controller.selectedDeliveryTime.value,
            elevation: 0,
            hint: const Text('Select Time'),
            style: const TextStyle(color: Colors.white),
            iconEnabledColor:Colors.black,
            items: controller.listOfDeliveryTime.map<DropdownMenuItem<DeliveryTimeModel>>((value)  {
              return DropdownMenuItem<DeliveryTimeModel>(
                value: value,
                child: Text(value.time,style:const TextStyle(color:Colors.black),),
              );
            }).toList(),
            onChanged: (DeliveryTimeModel? value) {
              controller.selectedDeliveryTime.value = value!;

            },
          ),
        ),
      ),
    );
  }

  Widget dropDownForName(){
    return Obx(
          ()=> Container(
        width: Get.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.blackColor,width: 1),
          color: AppColors.textFieldBackgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ShowNamesModel>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(8),
            value: controller.selectedShowName.value,
            elevation: 0,
            hint: const Text('Select Name'),
            style: const TextStyle(color: Colors.white),
            iconEnabledColor:Colors.black,
            items: controller.listOfShowNames.map<DropdownMenuItem<ShowNamesModel>>((value)  {
              return DropdownMenuItem<ShowNamesModel>(
                value: value,
                child: Text(value.name,style:const TextStyle(color:Colors.black),),
              );
            }).toList(),
            onChanged: (ShowNamesModel? value) {
              controller.selectedShowName.value = value!;

            },
          ),
        ),
      ),
    );
  }


}