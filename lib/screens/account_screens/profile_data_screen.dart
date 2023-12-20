import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/app_constants.dart';

import '../../controller/account_screens_controller/profile_data_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class ProfileDataScreen extends GetView<ProfileDataScreenController>{
  const ProfileDataScreen({super.key});

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
                          child:  Text('profile'.tr,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 53,),
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: Obx(
                        ()=> CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: controller.userInfoModel.value.profileImg,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>  Icon(Icons.person,size: 25,color: AppColors.lighterGrey,),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: labelText(label: '${"firstname".tr}:')),
                      const SizedBox(width: 20),
                      Expanded(child: Obx(()=> labelText(label: controller.userInfoModel.value.firstname))),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    child: Row(
                      children: [
                        Expanded(child: labelText(label: '${"lastname".tr}:')),
                        const SizedBox(width: 20),
                        Expanded(child: Obx(()=> labelText(label: controller.userInfoModel.value.lastname))),


                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: labelText(label: 'Phone Number:')),
                      const SizedBox(width: 20),
                      Expanded(child: Obx(()=> labelText(label: controller.userInfoModel.value.phone))),


                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    child: Row(
                      children: [
                        Expanded(child: labelText(label: '${"emaiaddress".tr}:')),
                        const SizedBox(width: 20),
                        Expanded(child: Obx(()=> labelText(label: controller.userInfoModel.value.email))),


                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: labelText(label: '${"gender".tr}:')),
                      const SizedBox(width: 20),
                      Expanded(child: Obx(()=> labelText(label: controller.userInfoModel.value.gender))),


                    ],
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: CustomFilledButton(onPress: (){Get.offNamed(kProfileScreen,arguments: controller.userInfoModel.value);}, text: 'Edit',backgroundColor: AppColors.redColor,width: Get.width/2,height: 35,radius: 10,))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText({required String label}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(label,style: heading1SemiBold(color: AppColors.lightBlack,fontSize: 18),),
    );
  }

}