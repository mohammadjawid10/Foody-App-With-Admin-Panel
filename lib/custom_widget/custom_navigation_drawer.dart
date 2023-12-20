import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../utils/app_colors.dart';
import '../controller/general_screens_controller/custom_navigation_drawer_controller.dart';
import 'custom_text_style.dart';
import 'image_widget.dart';

class CustomNavigationDrawer extends GetView<CustomNavigationDrawerController>{
  const CustomNavigationDrawer({super.key});

  @override
  final String tag=kNavigationDrawerController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          backgroundColor: AppColors.whiteColor,
          elevation: 5,
          child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: iconWidget(img: 'cross-icon.png',color: AppColors.redColor)),
                    ),
                    Center(child: Text("welcometo".tr,style: headingBold(fontSize: 25,color: AppColors.blackColor),)),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                        ()=> controller.isLoggedIn.value?Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height:24),
                                  _getDrawerNavItem(
                                icon: 'profile-icon.png',
                                title: "profile".tr),
                              /*_getDrawerNavItem(
                                icon: 'inbox-icon.png',
                                title: "Inbox",
                              ),*/
                              _getDrawerNavItem(
                                icon: 'order-icon.png',
                                title: "order".tr,
                              ),
                             /* _getDrawerNavItem(
                                icon: 'address-icon.png',
                                title: "My Address",
                              ),*/
                              _getDrawerNavItem(
                                icon: 'star-icon.png',
                                title: "myreviews".tr,
                              ),
                              _getDrawerNavItem(
                                icon: 'setting-icon.png',
                                title: "accountsettings".tr,
                              ),
                                _getDrawerNavItem(
                                  title: "Support",
                                ),
                                Obx(
                                      ()=> Visibility(
                                      visible: controller.isPromotionOption.value,
                                      child: Column(
                                        children: [
                                          _getDrawerNavItem(
                                            title: "about".tr,
                                          ),
                                          _getDrawerNavItem(
                                            title: "termsofservice".tr),
                                          _getDrawerNavItem(
                                            title: "Privacy Policy",
                                          ),
                                          _getDrawerNavItem(
                                            title: "Restaurants General Terms and condition",),
                                          _getDrawerNavItem(
                                            title: "colophon".tr,
                                          ),
                                        ],
                                      )),
                                ),
                                _getDrawerNavItem(
                                  title: "becomeapartnerrestaurant".tr,
                                ),
                                _getDrawerNavItem(
                                  title: "recommendarestaurant".tr,
                                ),
                                _getDrawerNavItem(
                                  title: "deliverylacations".tr,
                                ),
                                _getDrawerNavItem(
                                  title: "Language",
                                ),
                                _getDrawerNavItem(
                                  title: "logout".tr,
                                ),

                     /*           _getDrawerNavItem2(
                                  title: "Sign In",),
                                _getDrawerNavItem2(
                                  title: "Sign Up",),
                                _getDrawerNavItem2(
                                  title: "About Us",),
                                Obx(
                                      ()=> Visibility(
                                      visible: controller.isPromotionOption.value,
                                      child: Column(
                                        children: [
                                          _getDrawerNavItem2(
                                            title: "Support",),
                                          _getDrawerNavItem2(
                                            title: "Terms and condition",),
                                          _getDrawerNavItem2(
                                            title: "Restaurants General Terms and condition",),
                                          _getDrawerNavItem2(
                                            title: "Privacy Policy",),
                                          _getDrawerNavItem2(
                                            title: "Colophon",),
                                        ],
                                      )),
                                ),
                                _getDrawerNavItem2(
                                  title: "Language",),*/
                              ],
                            ),
                          ),
                        ):Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height:24),
                              _getDrawerNavItem2(
                                title: "signin".tr),
                              _getDrawerNavItem2(
                                title: "signup".tr),
                              _getDrawerNavItem2(
                                title: "Support",),
                              Obx(
                                    ()=> Visibility(
                                    visible: controller.isPromotionOption.value,
                                    child: Column(
                                      children: [
                                        _getDrawerNavItem2(
                                          title: "about".tr,),
                                        _getDrawerNavItem2(
                                          title: "termsofservice".tr),
                                        _getDrawerNavItem2(
                                          title: "Restaurants General Terms and condition",),
                                        _getDrawerNavItem2(
                                          title: "Privacy Policy",),
                                      ],
                                    )),
                              ),
                              _getDrawerNavItem2(
                                title: "becomeapartnerrestaurant".tr,
                              ),
                              _getDrawerNavItem2(
                                title: "recommendarestaurant".tr,
                              ),
                              _getDrawerNavItem2(
                                title: "Language"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ]
          )
      ),
    );
  }

  Widget _getDrawerNavItem({required String title,String icon=''}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 6),
        child: GestureDetector(
          onTap: () => controller.onDrawerItemClick(title: title),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.only(top: 18,left: 30,right: 10,bottom: 18),
            decoration: BoxDecoration(
                color: AppColors.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColors.blackColor,
                    width: 1
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.greyColor,
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 3.0,
                      spreadRadius: 2
                  ),
                ]
            ),
            child: Row(
              children: [
                icon!=''?iconWidget(img: icon,size: 22,color: title=='My reviews'? AppColors.redColor:null):const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: heading1(color: AppColors.blackColor,fontWeight: FontWeight.w300,fontSize: 20),
                  ),
                ),
                title=="Support"?Obx(()=> Icon(controller.isPromotionOption.value?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_outlined,color: AppColors.blackColor,)):
                title=='Language'?iconWidget(img: controller.isGermanLanguage.value?'german-circle.png':'uk-circle.png'):const SizedBox()


              ],
            ),
          ),
        ),
      );
  }

  Widget _getDrawerNavItem2({required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 6),
      child: GestureDetector(
        onTap: () => controller.onDrawerItemClick(title: title),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.only(top: 18,left: 30,right: 10,bottom: 18),
          decoration: BoxDecoration(
              color: AppColors.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.blackColor,
                width: 1
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColors.greyColor,
                    offset: const Offset(0.0, 5.0),
                    blurRadius: 3.0,
                    spreadRadius: 2
                ),
              ]
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: bodyMediumMedium(color: AppColors.blackColor,fontSize: 20),
                ),
              ),
              title=="Support"?Obx(()=> Icon(controller.isPromotionOption.value?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_outlined,color: AppColors.blackColor,)):
              title=='Language'?iconWidget(img: controller.isGermanLanguage.value?'german-circle.png':'uk-circle.png'):const SizedBox()
            ],
          ),
        )

      ),
    );
  }

}