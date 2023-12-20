import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';

import '../../controller/account_screens_controller/profile_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class ProfileScreen extends GetView<ProfileScreenController>{
  const ProfileScreen({super.key});

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
                          child:  Text('Edit ${'profile'.tr}',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 53,),
                  Row(
                    children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "firstname".tr),
                          customTextFieldForCardDetails(
                            controller: controller.firstNameTEController,
                            keyBoardType: TextInputType.name,
                              focusNode: controller.firstNameFocusNode,
                              onChanged: controller.fNameValidation
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.firstNameErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.firstNameErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(width: 20),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "lastname".tr),
                          customTextFieldForCardDetails(
                              keyBoardType: TextInputType.name,
                            controller: controller.lastNameTEController,
                              focusNode: controller.lastNameFocusNode,
                              onChanged: controller.lNameValidation
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.lastNameErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.lastNameErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      )),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(label: 'Phone Number'),
                            customTextFieldForCardDetails(
                              keyBoardType: TextInputType.number,
                              controller: controller.phoneNumberNameTEController,
                              focusNode: controller.phoneNumberNameFocusNode,
                              onChanged: controller.phoneValidation
                            ),
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
                        )),
                      /*  const SizedBox(width: 20),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(label: "emaiaddress".tr),
                            customTextFieldForCardDetails(
                              keyBoardType: TextInputType.emailAddress,
                              controller: controller.emailAddressTEController,
                              focusNode: controller.emailFocusNode,
                              onChanged: controller.emailValidation,

                            ),
                            Obx(
                                  ()=> Visibility(
                                visible: controller.emailErrorVisible.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:7),
                                  child: Text(controller.emailErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                ),
                              ),
                            ),
                          ],
                        )),*/

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "gender".tr),
              DropdownButtonFormField(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(10),
                  hint: const Text('Select Gender'),
                  icon: const SizedBox(),
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    filled: true,
                    fillColor: AppColors.textFieldBackgroundColor,
                  ),
                  validator: (value) => value == null ? "Select a Gender" : null,
                  dropdownColor: Colors.white,
                  value: controller.selectedValue.value,
                  onChanged: (String? newValue) {
                      controller.selectedValue.value = newValue!;
                  },
                  items: controller.dropdownItems),
                        ],
                      )),
                      const SizedBox(width: 20),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelText(label: "profileimage".tr),
                          GestureDetector(
                            onTap: (){
                              controller.onUploadImage();
                            },
                            child: Container(
                              height: 52,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.textFieldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),

                              ),
                              child: Align(alignment:Alignment.centerLeft,child: Obx(()=> Text(controller.profileImage.value,style: heading1(color: AppColors.blackColor,fontSize: 12,fontWeight: FontWeight.w300),maxLines: 1,overflow: TextOverflow.ellipsis,))),
                            ),
                          ),
                          Obx(
                                ()=> Visibility(
                              visible: controller.profileErrorVisible.value,
                              child: Padding(
                                padding: const EdgeInsets.only(top:7),
                                child: Text(controller.profileErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                              ),
                            ),
                          ),
                        ],
                      )),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30,bottom: 70),
                    child: Row(
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(label: "zip".tr),
                            customTextFieldForCardDetails(
                                keyBoardType: TextInputType.number,
                                controller: controller.zipTEController,
                                focusNode: controller.zipFocusNode,
                                onChanged: controller.zipValidation
                            ),
                            Obx(
                                  ()=> Visibility(
                                visible: controller.zipErrorVisible.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:7),
                                  child: Text(controller.zipErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                ),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: 20),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(label: "city".tr),
                            customTextFieldForCardDetails(
                              keyBoardType: TextInputType.name,
                              controller: controller.cityTEController,
                              focusNode: controller.cityFocusNode,
                              onChanged: controller.cityValidation,

                            ),
                            Obx(
                                  ()=> Visibility(
                                visible: controller.cityErrorVisible.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:7),
                                  child: Text(controller.cityErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                ),
                              ),
                            ),
                          ],
                        )),

                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: CustomFilledButton(onPress: (){controller.onUpdateButton();}, text: "save".tr,backgroundColor: AppColors.redColor,width: Get.width/2,height: 57,radius: 10,))

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
      child: Text(label,style: bodyMediumMedium(color: AppColors.lightBlack,fontSize: 15),),
    );
  }

  Widget customTextFieldForCardDetails(
      {String hintText = "",
        bool enabled = true,
        bool isAllProduct = false,
        bool isPassword = false,
        bool showpassword = false,
        Widget? suffixIcon,
        Widget? prefexIcon,
        Color color = Colors.white,
        int? maxLength,
        TextInputType? keyBoardType,
        double? fontSize,
        dynamic onChanged,
        Color? fillColor,
        bool readOnly=false,
        double radius = 8,
        TextEditingController? controller,
        bool isMultiLine = false,
        FocusNode? focusNode,
        double height = 52}) {
    return SizedBox(
      height: isMultiLine ? null : height,
      child: TextField(
        readOnly: readOnly,
        focusNode: focusNode,
        enabled: enabled,
        controller: controller,
        obscureText: showpassword,
        textAlign: maxLength != null ? TextAlign.center : TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        maxLength: maxLength,
        keyboardType: keyBoardType,
        style: maxLength != null
            ? heading1SemiBold()
            : bodyMediumMedium(color: AppColors.blackColor,fontSize: fontSize),
        obscuringCharacter: '*',
        decoration: InputDecoration(
          border: border(radius: radius),
          enabledBorder: border(radius: radius, isFocused: false),
          focusColor: AppColors.greyColor,
          focusedBorder: InputBorder.none,
          filled: true,
          hintStyle: bodyMediumMedium(color: AppColors.textColor,fontSize: fontSize),
          hintText: hintText,
          fillColor: fillColor??AppColors.textFieldBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5)
        ),
        onChanged: (text) {
          if(onChanged!=null) {
            onChanged(text);
          }
        },
      ),
    );
  }

  InputBorder border({required double radius, bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      borderSide: BorderSide(
        width: 0,
        color: isFocused ? AppColors.greyColor: AppColors.borderColor,
        style: BorderStyle.solid,
      ),
    );
  }

}