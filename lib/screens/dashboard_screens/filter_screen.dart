import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/custom_widget/image_widget.dart';
import '../../controller/dashboard_screens_controller/filter_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../utils/app_colors.dart';

class FilterScreen extends GetView<FilterScreenController> {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(onTap:(){
                controller.dashboardScreenController.changeTabIndex(0);
              },child: iconWidget(img: 'cross-icon.png')),
              Padding(
                padding: const EdgeInsets.only(top: 110,bottom: 72),
                child: optionChooseWidget(title: "openresturant".tr,value: controller.isRestaurantOpen),
              ),
             optionChooseWidget(title: "freedelivery".tr,value: controller.isFreeDelivery),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 72.0),
                child: ratingWidget(title: "restaurantratings".tr, value: ''),
              ),
              minimumOrderWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child:  Align(
                    alignment: Alignment.topRight,
                    child: CustomFilledButton(onPress: (){
                      controller.isRestaurantOpen.value=false;
                      controller.isFreeDelivery.value=false;
                      controller.rating.value=0.0;
                      controller.currentSliderValue.value=0.0;
                      controller.onFilterApply();

                    }, text: 'Clear Filter',backgroundColor: AppColors.redColor,width: 115,height: 31,radius: 10,fontSize: 15,)),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget optionChooseWidget({required String title, required RxBool value}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 20),),
        Obx(
        ()=> FlutterSwitch(
            toggleSize: 20,
            height: 20,
            width: 58,
            showOnOff: true,
            valueFontSize: 12,
            value: value.value,
            activeText: "ON",
            activeTextColor: AppColors.whiteColor,
            inactiveText: "OFF",
            activeColor: AppColors.redColor,
            inactiveColor: AppColors.lighterGrey,
            activeTextFontWeight: FontWeight.normal,
            inactiveTextFontWeight: FontWeight.normal,
            onToggle: (val) {
                value.value = val;
                controller.onFilterApply();
            },
          ),
        ),

      ],
    );
  }

  Widget ratingWidget({required String title, required String value}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 20),),
        Obx(
          ()=> RatingBar.builder(
            itemSize: 18,
            initialRating: controller.rating.value,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => iconWidget(img: 'star-icon.png',size: 15,color: AppColors.redColor),
            onRatingUpdate: (rating) {
              controller.rating.value=rating;
              controller.onFilterApply();
            },
          ),
        )

      ],
    );
  }

  Widget minimumOrderWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("minimumorder".tr,style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 20),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
                  ()=> Slider(
                value: controller.currentSliderValue.value,
                max: 100,
                min: 0.0,
                thumbColor: AppColors.whiteColor,
                activeColor: AppColors.blackColor.withOpacity(0.3),
                inactiveColor: AppColors.blackColor.withOpacity(0.3),
                divisions: 20,
                label: controller.currentSliderValue.value.toStringAsFixed(0),
                onChanged: (double value) {
                  controller.currentSliderValue.value = value;
                  controller.onFilterApply();
                },
              ),
            ),
            Obx(()=> Text(controller.currentSliderValue.value.toStringAsFixed(0)=='0'?'No Minimum':'€ ${controller.currentSliderValue.value.toStringAsFixed(0)}',style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 16),)),
          ],
        )
      ],
    );
  }


}
