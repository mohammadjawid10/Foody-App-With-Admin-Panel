import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/model/addons_list_model.dart';
import 'package:liefermars/model/get_menu_option_model.dart';

import '/controller/dashboard_screens_controller/product_info_screen_controller.dart';
import '/custom_widget/image_widget.dart';
import '/model/option_model.dart';
import '/utils/app_colors.dart';

class ProductInfoScreen extends GetView<ProductInfoScreenController> {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(result: true);
                    },
                    child: iconWidget(
                      img: 'cross-icon.png',
                      color: AppColors.redColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 70),
                    child: Center(
                      child: Text(
                        controller.menuModelByCategory.name,
                        style: bodyMediumMedium(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.menuModelByCategory.description,
                        style: bodyMediumMedium(fontSize: 12),
                      ),
                    ],
                  ),
                  Obx(
                    //TODO: FITNA
                    () => controller.listOfOptionItemModel.isNotEmpty
                        ? itemsDropDownForOptions(
                            label: controller
                                .getMenuOptionModel.options.optionName,
                            listOfOptionModel: controller.listOfOptionItemModel,
                          )
                        : const SizedBox(),
                  ),
                  Obx(() => controller.addonsListForDropDown.isNotEmpty
                      ? Column(
                          children: [
                            for (int i = 0;
                                i < controller.addonsListForDropDown.length;
                                i++)
                              Obx(
                                () => itemsDropDown(
                                  label:
                                      controller.addonsListForDropDown[i].name,
                                  listOfOptionModel:
                                      controller.addonsListForDropDown[i].opt,
                                  selectedValue: controller
                                      .addonsListForDropDown[i].opt[0],
                                ),
                              ),
                          ],
                        )
                      : const SizedBox()),
                  Obx(
                    () => controller.addonsListForSwitch.isNotEmpty
                        ? Column(
                            children: [
                              for (int i = 0;
                                  i < controller.addonsListForSwitch.length;
                                  i++)
                                switchWidget(
                                  addonsListModel:
                                      controller.addonsListForSwitch[i],
                                ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  addToCart()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemsDropDown(
      {required String label,
      required List<OptionModel> listOfOptionModel,
      required OptionModel selectedValue}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: bodyMediumMedium(color: AppColors.blackColor, fontSize: 12),
          ),
          const SizedBox(
            height: 11,
          ),
          DropdownButtonFormField<OptionModel>(
            elevation: 0,
            menuMaxHeight: 400,
            borderRadius: BorderRadius.circular(10),
            hint: Text(
              selectedValue.title,
              style: heading1(color: AppColors.blackColor, fontSize: 12),
            ),
            style: heading1(color: AppColors.blackColor, fontSize: 12),
            decoration: InputDecoration(
              border: border(radius: 25, isFocused: true),
              focusedBorder: border(radius: 25, isFocused: true),
              filled: true,
              fillColor: AppColors.textFieldBackgroundColor,
            ),
            validator: (value) => value == null ? "mit Ananas" : null,
            dropdownColor: Colors.white,
            value: selectedValue,
            onChanged: (OptionModel? newValue) {
              for (int j = 0; j < controller.selectedValue.length; j++) {
                if (newValue!.addonId == controller.selectedValue[j].addonId) {
                  controller.totalPrice.value = controller.totalPrice.value -
                      double.parse(controller.selectedValue[j].price != ''
                          ? controller.selectedValue[j].price
                          : '0.0');
                  controller.selectedValue.removeAt(j);
                }
              }
              controller.selectedValue.add(newValue!);
              if (controller.selectedValue.isNotEmpty) {
                controller.totalPrice.value =
                    double.parse(controller.menuModelByCategory.price);
                for (int i = 0; i < controller.multiSelectedValue.length; i++) {
                  controller.totalPrice.value = controller.totalPrice.value +
                      double.parse(controller.multiSelectedValue[i].price);
                }
                for (int i = 0; i < controller.selectedValue.length; i++) {
                  controller.totalPrice.value = controller.totalPrice.value +
                      double.parse(controller.selectedValue[i].price != ''
                          ? controller.selectedValue[i].price
                          : '0.0');
                }
              }
            },
            items: listOfOptionModel.map((OptionModel item) {
              return DropdownMenuItem<OptionModel>(
                value: item,
                child: Text('${item.title} ${item.price} €'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget itemsDropDownForOptions({
    required String label,
    required List<OptionItemModel> listOfOptionModel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: bodyMediumMedium(color: AppColors.blackColor, fontSize: 12),
          ),
          const SizedBox(
            height: 11,
          ),
          DropdownButtonFormField<OptionItemModel>(
            elevation: 0,
            menuMaxHeight: 400,
            borderRadius: BorderRadius.circular(10),
            hint: Text(
              controller.selectedOptionItemModel.name,
              style: heading1(color: AppColors.blackColor, fontSize: 12),
            ),
            style: heading1(color: AppColors.blackColor, fontSize: 12),
            decoration: InputDecoration(
              border: border(radius: 25, isFocused: true),
              focusedBorder: border(radius: 25, isFocused: true),
              filled: true,
              fillColor: AppColors.textFieldBackgroundColor,
            ),
            validator: (value) => value == null ? "mit Ananas" : null,
            dropdownColor: Colors.white,
            value: controller.selectedOptionItemModel,
            onChanged: (OptionItemModel? newValue) {
              controller.selectedOptionItemModel = newValue!;
              controller.menuModelByCategory.price = newValue.price;
              controller.totalPrice.value = double.parse(newValue.price);
              for (int i = 0; i < controller.multiSelectedValue.length; i++) {
                controller.totalPrice.value = controller.totalPrice.value +
                    double.parse(controller.multiSelectedValue[i].price);
              }
              controller.onOptionChange(newValue);
            },
            items: listOfOptionModel.map((OptionItemModel item) {
              return DropdownMenuItem<OptionItemModel>(
                value: item,
                child: Text('${item.name} ${item.price} €'),
              );
            }).toList(),
          ),
        ],
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
        color: isFocused ? AppColors.blackColor : AppColors.blackColor,
        style: BorderStyle.solid,
      ),
    );
  }

  Widget switchWidget({required AddonsListModel addonsListModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          addonsListModel.name,
          style: bodyMediumMedium(color: AppColors.blackColor, fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 17),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addonsListModel.opt.length < 4
                ? addonsListModel.opt.length
                : controller.totalItem.value,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: extraChooseOption(
                  optionModel: addonsListModel.opt[index],
                  value: false.obs,
                ),
              );
            },
          ),
        ),
        addonsListModel.opt.length > 4
            ? GestureDetector(
                onTap: () {
                  if (addonsListModel.opt.length > 4 &&
                      controller.totalItem.value == 3) {
                    controller.totalItem.value = addonsListModel.opt.length;
                  } else {
                    controller.totalItem.value = 3;
                  }
                },
                child: Text(
                  addonsListModel.opt.length > 4 &&
                          controller.totalItem.value == 3
                      ? 'See more'
                      : 'See less',
                  style: bodyMediumMedium(
                      color: AppColors.blackColor, fontSize: 10),
                ))
            : const SizedBox(),
      ],
    );
  }

  Widget extraChooseOption({
    required OptionModel optionModel,
    required RxBool value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Obx(
              () => FlutterSwitch(
                toggleSize: 14,
                height: 23,
                width: 38,
                showOnOff: true,
                valueFontSize: 12,
                value: value.value,
                activeText: '',
                activeColor: AppColors.redColor,
                inactiveColor: AppColors.whiteColor,
                inactiveToggleColor: AppColors.blackColor,
                inactiveSwitchBorder: Border.all(color: AppColors.lighterGrey),
                activeTextFontWeight: FontWeight.normal,
                inactiveTextFontWeight: FontWeight.normal,
                onToggle: (val) {
                  value.value = val;
                  if (value.value == false) {
                    if (controller.getMenuOptionModel.options.optionName !=
                            '' &&
                        controller.getMenuOptionModel.options.optionItemList
                            .isNotEmpty) {
                      for (int j = 0;
                          j < controller.multiSelectedValue.length;
                          j++) {
                        if (optionModel.id ==
                            controller.multiSelectedValue[j].id) {
                          controller.totalPrice.value = controller
                                  .totalPrice.value -
                              double.parse(
                                  controller.multiSelectedValue[j].price != ''
                                      ? controller.multiSelectedValue[j].price
                                      : '0.0');
                          controller.multiSelectedValue.removeAt(j);
                        }
                      }
                    } else {
                      for (int j = 0;
                          j < controller.multiSelectedValue.length;
                          j++) {
                        if (optionModel.id ==
                            controller.multiSelectedValue[j].id) {
                          controller.totalPrice.value = controller
                                  .totalPrice.value -
                              double.parse(
                                  controller.multiSelectedValue[j].price != ''
                                      ? controller.multiSelectedValue[j].price
                                      : '0.0');
                          controller.multiSelectedValue.removeAt(j);
                        }
                      }
                    }
                  } else {
                    if (controller.getMenuOptionModel.options.optionName !=
                            '' &&
                        controller.getMenuOptionModel.options.optionItemList
                            .isNotEmpty) {
                      controller.multiSelectedValue.add(optionModel);
                      controller.totalPrice.value =
                          double.parse(controller.menuModelByCategory.price);
                      if (controller.multiSelectedValue.isNotEmpty) {
                        for (int i = 0;
                            i < controller.multiSelectedValue.length;
                            i++) {
                          controller.totalPrice.value =
                              controller.totalPrice.value +
                                  double.parse(
                                      controller.multiSelectedValue[i].price);
                        }
                      }
                      if (controller.selectedValue.isNotEmpty) {
                        for (int i = 0;
                            i < controller.selectedValue.length;
                            i++) {
                          controller.totalPrice.value = controller
                                  .totalPrice.value +
                              double.parse(controller.selectedValue[i].price);
                        }
                      }
                    } else {
                      controller.multiSelectedValue.add(optionModel);
                      controller.totalPrice.value =
                          double.parse(controller.menuModelByCategory.price);
                      for (int i = 0;
                          i < controller.selectedValue.length;
                          i++) {
                        controller.totalPrice.value = controller
                                .totalPrice.value +
                            double.parse(controller.selectedValue[i].price != ''
                                ? controller.selectedValue[i].price
                                : '0.0');
                      }
                      if (controller.multiSelectedValue.isNotEmpty) {
                        for (int i = 0;
                            i < controller.multiSelectedValue.length;
                            i++) {
                          controller.totalPrice.value =
                              controller.totalPrice.value +
                                  double.parse(
                                      controller.multiSelectedValue[i].price);
                        }
                      } else {
                        // controller.totalPrice.value=double.parse(controller.menuModelByCategory.price);
                      }
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              optionModel.title,
              style:
                  bodyMediumMedium(color: AppColors.blackColor, fontSize: 10),
            ),
            const SizedBox(width: 10),
            Text(
              '${optionModel.price} €',
              style:
                  bodyMediumMedium(color: AppColors.blackColor, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget addToCart() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    if (controller.totalCount.value > 1) {
                      controller.totalPrice.value =
                          controller.totalPrice.value /
                              controller.totalCount.value;
                      controller.totalCount.value--;
                    }
                  },
                  child: iconWidget(
                      img: 'minus-order-icon.png',
                      size: 24,
                      color: AppColors.blackColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() => Text(
                      controller.totalCount.value.toString(),
                      style: heading1SemiBold(
                          color: AppColors.blackColor, fontSize: 24),
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    controller.totalPrice.value = controller.totalPrice.value /
                        controller.totalCount.value;
                    controller.totalCount.value++;
                    controller.totalPrice.value = controller.totalPrice.value *
                        controller.totalCount.value;
                  },
                  child: iconWidget(
                      img: 'add-order-icon.png',
                      size: 24,
                      color: AppColors.blackColor)),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (controller.getMenuOptionModel.options.optionName != '' &&
                  controller
                      .getMenuOptionModel.options.optionItemList.isNotEmpty) {
                controller.onCartForOptionTap();
              } else {
                controller.onCartTap();
              }
            },
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
              decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.redColor.withOpacity(0.5),
                        offset: const Offset(0.0, 5.0),
                        blurRadius: 3.0,
                        spreadRadius: 2),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    "addtocart".tr,
                    style:
                        headingBold(color: AppColors.whiteColor, fontSize: 13),
                  )),
                  Obx(() => Text(
                        '${controller.totalPrice.value.toStringAsFixed(2)} €',
                        style: headingBold(
                            color: AppColors.whiteColor, fontSize: 13),
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
