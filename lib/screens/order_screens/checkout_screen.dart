import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/order_screens_controller/checkout_screen_controller.dart';
import 'package:liefermars/custom_widget/image_widget.dart';
import 'package:liefermars/model/time_model.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_normal_appbar.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../utils/app_colors.dart';

class CheckOutScreen extends GetView<CheckOutScreenController> {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomNormalAppbar(title: "checkout".tr)),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Stack(
      children: [
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 21, right: 21, bottom: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                            ()=> FilledButton(
                          onPressed: (){
                            controller.status.value='Delivery';
                            controller.getUserAddressInformation();
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: controller.status.value=='Delivery'?Colors.red:const Color(0xFFF9F1F1),
                              minimumSize: const Size(100, 30),
                              elevation: controller.status.value=='Delivery'?7:2
                          ),
                          child: Text('Delivery',
                              style: headingBold(
                                  color: controller.status.value=='Delivery'?Colors.white:Colors.black, fontSize: 13)),
                        ),
                      ),
                      Obx(
                            ()=> FilledButton(
                          onPressed: (){
                            controller.status.value='Pickup';
                            controller.getUserAddressInformation();
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor:  controller.status.value=='Pickup'?Colors.red:const Color(0xFFF9F1F1),
                              minimumSize: const Size(100, 30),
                              elevation: controller.status.value=='Pickup'?7:2
                          ),
                          child: Text('Pickup',
                              style: headingBold(
                                  color: controller.status.value=='Pickup'?Colors.white:Colors.black, fontSize: 13)),
                        ),
                      ),
                    ],
                  ),*/
                  const SizedBox(height: 20),
                  labelText(label: "personalinformation".tr),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              if (controller.status.value == 'Delivery') {
                                bool result =
                                    await Get.toNamed(kDeliveryScreen);
                                if (result) {
                                  controller.getUserAddressInformation();
                                }
                              } else if (controller.status.value == 'Pickup') {
                                bool result = await Get.toNamed(kPickUpScreen);
                                if (result) {
                                  controller.getUserAddressInformation();
                                }
                              }
                            },
                            child: detailWidget()),
                        Obx(
                          () => Visibility(
                            visible: controller.isErrorMsg.value,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                controller.errorMessage.value,
                                style: heading1(
                                    color: AppColors.redColor, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  labelText(label: 'Payment method'),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 40),
                    child: GestureDetector(
                        onTap: () async {
                          bool isAllDataValid = false;
                          isAllDataValid =
                              !controller.nameEmailPhoneValidation();
                          if (isAllDataValid) {
                            bool resp = await Get.toNamed(kPaymentMethodScreen,
                                arguments: controller.getCartModel);
                            if (resp) {
                              controller.getPaymentInformation();
                            }
                          }
                        },
                        child: paymentMethod()),
                  ),
                  labelText(label: "estmdeliverytimesort".tr),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 7, bottom: 40, right: 30),
                    child: deliveryTime(),
                  ),
                  labelText(label: "note".tr),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 40),
                    child: addNotes(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 21,
            right: 21,
            child: CustomFilledButton(
              onPress: () {
                controller.onCheckOutClick();
              },
              text:
                  '${"orderandpay".tr} (${controller.totalAmount.toStringAsFixed(2)} €)',
              backgroundColor: AppColors.redColor,
              height: 45,
              radius: 15,
              fontSize: 15,
            ))
      ],
    );
  }

  Widget labelText({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: heading1SemiBold(color: AppColors.blackColor, fontSize: 20),
      ),
    );
  }

  Widget detailWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            padding:
                const EdgeInsets.only(top: 24, left: 10, right: 10, bottom: 24),
            decoration: BoxDecoration(
                color: AppColors.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.greyColor,
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 3.0,
                      spreadRadius: 2),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      controller.addressModel.value.street != '' &&
                              controller.status.value == 'Delivery'
                          ? controller.addressModel.value.street
                          : controller.addressModel.value.clientName != '' &&
                                  controller.status.value == 'Pickup'
                              ? controller.addressModel.value.clientName
                              : '',
                      style:
                          heading1(color: AppColors.blackColor, fontSize: 14),
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.blackColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget addNotes() {
    return CustomTextField(
      hintText: 'Please don’t ring the bell baby is sleeping.',
      controller: controller.notesTEController,
    );
  }

  Widget deliveryTime() {
    return Obx(
      () => Container(
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor,
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 3.0,
                  spreadRadius: 2),
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<TimeModel>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(5),
            value: controller.selectedDeliveryTime.value,
            elevation: 0,
            hint: const Text('Select Time'),
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: controller.listOfTimeModel
                .map<DropdownMenuItem<TimeModel>>((value) {
              return DropdownMenuItem<TimeModel>(
                value: value,
                child: Text(
                  value.time,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (TimeModel? value) {
              controller.selectedDeliveryTime.value = value!;
            },
          ),
        ),
      ),
    );
  }

  Widget paymentMethod() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            padding:
                const EdgeInsets.only(top: 24, left: 10, right: 10, bottom: 24),
            decoration: BoxDecoration(
                color: AppColors.textFieldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.greyColor,
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 3.0,
                      spreadRadius: 2),
                ]),
            child: Row(
              children: [
                Row(
                  children: [
                    Obx(() => iconWidget(
                        img: controller.paymentModel.value.imagePayment != ''
                            ? controller.paymentModel.value.imagePayment
                            : 'cash-icon.png',
                        size: 20)),
                    const SizedBox(
                      width: 42,
                    ),
                    Obx(() => Text(
                          controller.paymentModel.value.paymentType,
                          style: heading1(
                              color: AppColors.blackColor, fontSize: 15),
                        )),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.radio_button_checked,
                  color: AppColors.redColor,
                  size: 20,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 23,
        ),
        Icon(
          Icons.arrow_forward_ios_sharp,
          color: AppColors.blackColor,
          size: 20,
        )
      ],
    );
  }
}
