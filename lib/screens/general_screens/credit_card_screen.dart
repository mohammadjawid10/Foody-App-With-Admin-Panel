import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/general_screens_controller/credit_card_screen_controller.dart';

import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class CreditCardScreen extends GetView<CreditCardScreenController>{
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 40),
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
                          child: Text('Credit or Debit Card',style: headingBold(color: AppColors.blackColor,fontSize: 16),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(label: 'Cardholder Name'),
                      customTextFieldForCardDetails(
                          keyBoardType: TextInputType.name,
                        controller: controller.cardHolderTEController,
                        focusNode: controller.cardHolderFocusNode,
                        onChanged: controller.cardHolderValidation
                      ),
                      Obx(
                            ()=> Visibility(
                          visible: controller.cardHolderErrorVisible.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top:7),
                            child: Text(controller.cardHolderErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(label: 'Card Number'),
                      Row(
                        children: [
                          Expanded(child: Column(
                            children: [
                              customTextFieldForCardDetails(
                                controller: controller.cardNum1TEController,
                                focusNode: controller.cardNum1FocusNode,
                                  keyBoardType: TextInputType.number,
                                  onChanged: controller.cardNum1Validation
                              ),
                              Obx(
                                    ()=> Visibility(
                                  visible: controller.cardNum1ErrorVisible.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:7),
                                    child: Text(controller.cardNum1ErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(width: 20),
                          Expanded(child: Column(
                            children: [
                              customTextFieldForCardDetails(
                                  keyBoardType: TextInputType.number,
                                  controller: controller.cardNum2TEController,
                                  focusNode: controller.cardNum2FocusNode,
                                  onChanged: controller.cardNum2Validation
                              ),
                              Obx(
                                    ()=> Visibility(
                                  visible: controller.cardNum2ErrorVisible.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:7),
                                    child: Text(controller.cardNum2ErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(width: 20),
                          Expanded(child: Column(
                            children: [
                              customTextFieldForCardDetails(
                                  keyBoardType: TextInputType.number,
                                  controller: controller.cardNum3TEController,
                                  focusNode: controller.cardNum3FocusNode,
                                  onChanged: controller.cardNum3Validation
                              ),
                              Obx(
                                    ()=> Visibility(
                                  visible: controller.cardNum3ErrorVisible.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:7),
                                    child: Text(controller.cardNum3ErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(width: 20),
                          Expanded(child: Column(
                            children: [
                              customTextFieldForCardDetails(
                                  keyBoardType: TextInputType.number,
                                  controller: controller.cardNum4TEController,
                                  focusNode: controller.cardNum4FocusNode,
                                  onChanged: controller.cardNum4Validation
                              ),
                              Obx(
                                    ()=> Visibility(
                                  visible: controller.cardNum4ErrorVisible.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:7),
                                    child: Text(controller.cardNum4ErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(label: 'Expiration Date '),
                            customTextFieldForCardDetails(
                                keyBoardType: TextInputType.number,
                                controller: controller.expirationDateTEController,
                                focusNode: controller.expireDateFocusNode,
                                onChanged: controller.expireDateValidation
                            ),
                            Obx(
                                  ()=> Visibility(
                                visible: controller.expireDateErrorVisible.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:7),
                                  child: Text(controller.expireDateErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labelText(label: 'CVC/CVV '),
                            customTextFieldForCardDetails(
                                keyBoardType: TextInputType.number,
                                controller: controller.cvcTEController,
                                focusNode: controller.cvcFocusNode,
                                onChanged: controller.cvcValidation
                            ),
                            Obx(
                                  ()=> Visibility(
                                visible: controller.cvcErrorVisible.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:7),
                                  child: Text(controller.cvcErrorMsg.value,style: heading1(color: AppColors.redColor,fontSize: 12),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 101,),
                  CustomFilledButton(onPress: (){}, text: 'Pay €  47.87',backgroundColor: AppColors.redColor,),
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
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          border: border(radius: radius),
          enabledBorder: border(radius: radius, isFocused: false),
          focusColor: AppColors.greyColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyColor, width: 0.6),
            borderRadius: BorderRadius.circular(radius),
          ),
          filled: true,
          hintStyle: bodyMediumMedium(color: AppColors.textColor,fontSize: fontSize),
          hintText: hintText,
          fillColor: fillColor??AppColors.textFieldBackgroundColor,
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
        width: 1,
        color: isFocused ? AppColors.blackColor: AppColors.blackColor,
        style: BorderStyle.solid,
      ),
    );
  }

}