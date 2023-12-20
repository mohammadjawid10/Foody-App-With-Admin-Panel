import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/image_widget.dart';
import '../../controller/order_screens_controller/order_view_screen_controller.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../model/cart_item_model.dart';
import '../../utils/app_colors.dart';

class OrderViewScreen extends GetView<OrderViewScreenController> {
  const OrderViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back(result: true);
                  },
                  child: iconWidget(
                      img: 'cross-icon.png',
                      size: 21,
                      color: AppColors.redColor)),
              Row(
                children: [
                  Obx(
                    () => FilledButton(
                      onPressed: () {
                        controller.status.value = 'Delivery';
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: controller.status.value == 'Delivery'
                            ? AppColors.redColor
                            : AppColors.whiteColor,
                        minimumSize: const Size(100, 30),
                      ),
                      child: Text('Delivery',
                          style: headingBold(
                              color: controller.status.value == 'Delivery'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13)),
                    ),
                  ),
                  Obx(
                    () => FilledButton(
                      onPressed: () {
                        controller.status.value = 'Pickup';
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: controller.status.value == 'Pickup'
                            ? AppColors.redColor
                            : AppColors.whiteColor,
                        minimumSize: const Size(100, 30),
                      ),
                      child: Text('Pickup',
                          style: headingBold(
                              color: controller.status.value == 'Pickup'
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13)),
                    ),
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
        body: _getBody(),
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 60),
              child: Obx(
                () => controller.getCartModel.value.items.isNotEmpty &&
                        controller.notesTEController.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ITEMS',
                            style: heading1SemiBold(
                                color: AppColors.blackColor, fontSize: 25),
                          ),
                          for (int i = 0;
                              i < controller.getCartModel.value.items.length;
                              i++)
                            headingItemWidget(
                                index: i + 1,
                                cartItemModel:
                                    controller.getCartModel.value.items[i]),
                          discountCode(),
                          controller.getCartModel.value.cartTotalAmount <
                                  double.parse(controller
                                      .getCartModel.value.minimumOrder)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Container(
                                    width: Get.width,
                                    padding: const EdgeInsets.only(
                                        top: 13,
                                        left: 10,
                                        right: 10,
                                        bottom: 13),
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.redColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.greyColor,
                                              offset: const Offset(0.0, 5.0),
                                              blurRadius: 3.0,
                                              spreadRadius: 2),
                                        ]),
                                    child: Text(
                                        'Amount needed to reach the minimum order ${controller.getCartModel.value.minimumOrder} € value'),
                                  ),
                                )
                              : const SizedBox(),
                          slipWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : controller.getCartModel.value.items.isNotEmpty &&
                            controller.notesTEController.isEmpty
                        ? const Center(child: SizedBox())
                        : Center(
                            child: Text(
                              'NO ITEMS FOUND',
                              style: heading1SemiBold(
                                  color: AppColors.blackColor, fontSize: 25),
                            ),
                          ),
              ),
            ),
          ),
        ),
        Obx(
          () => controller.getCartModel.value.items.isNotEmpty
              ? Positioned(
                  bottom: 20,
                  left: 21,
                  right: 21,
                  child: CustomFilledButton(
                    onPress: () {
                      if (controller.status.value == 'Pickup') {
                        controller.getCartModel.value.cartTotalAmount =
                            controller.getCartModel.value.cartTotalAmount -
                                double.parse(
                                    controller.getCartModel.value.deliveryFee);
                      }
                      controller.getCartModel.value.cartTotalAmount <
                              double.parse(
                                  controller.getCartModel.value.minimumOrder)
                          ? null
                          : controller.onCheckOutTap();
                    },
                    text:
                        'Go to ${"checkout".tr}   € ${controller.status.value == 'Pickup' ? (controller.getCartModel.value.cartTotalAmount - double.parse(controller.getCartModel.value.deliveryFee)).toStringAsFixed(2) : controller.getCartModel.value.cartTotalAmount.toStringAsFixed(2)}',
                    backgroundColor:
                        controller.getCartModel.value.cartTotalAmount <
                                double.parse(
                                    controller.getCartModel.value.minimumOrder)
                            ? AppColors.redColor.withOpacity(0.26)
                            : AppColors.redColor,
                    height: 45,
                    radius: 15,
                    fontSize: 15,
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }

  Widget headingItemWidget(
      {required int index, required CartItemModel cartItemModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                index.toString(),
                style:
                    heading1SemiBold(color: AppColors.blackColor, fontSize: 16),
              ),
              const SizedBox(
                width: 57,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItemModel.name,
                      style: heading1SemiBold(
                          color: AppColors.blackColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (int i = 0;
                        i < cartItemModel.multiAddonsList.length;
                        i++)
                      Text(
                        '${i + 1} ${cartItemModel.multiAddonsList[i].multiAddonName} ${cartItemModel.multiAddonsList[i].multiAddonPrice}€',
                        style:
                            heading1(color: AppColors.blackColor, fontSize: 12),
                      ),
                    for (int i = 0;
                        i < cartItemModel.singleAddonsList.length;
                        i++)
                      Text(
                        '${i + 1} ${cartItemModel.singleAddonsList[i].addonname} ${cartItemModel.singleAddonsList[i].addonprice}€',
                        style:
                            heading1(color: AppColors.blackColor, fontSize: 12),
                      ),
                    cartItemModel.optionModel.name != ''
                        ? Text(
                            ' ${cartItemModel.optionModel.name} ${cartItemModel.optionModel.optionValue}',
                            style: heading1(
                                color: AppColors.blackColor, fontSize: 12),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Text(
                '€ ${cartItemModel.itemPrice.toStringAsFixed(2)}',
                style:
                    heading1SemiBold(color: AppColors.blackColor, fontSize: 15),
              ),
            ],
          ),
        ),
        notesWidget(
            cartItemModel: cartItemModel,
            notesTEController: controller.notesTEController[index - 1]),
        detailWidget(cartItemModel: cartItemModel),
      ],
    );
  }

  Widget notesWidget(
      {required CartItemModel cartItemModel,
      required TextEditingController notesTEController}) {
    //controller.totalQuantity.value=int.parse(cartItemModel.quantity);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Notes',
                style:
                    bodyMediumMedium(color: AppColors.blackColor, fontSize: 16),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomTextField(
                  controller: notesTEController,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        if (int.parse(cartItemModel.quantity.value) > 1) {
                          cartItemModel.quantity.value =
                              (int.parse(cartItemModel.quantity.value) - 1)
                                  .toString();
                          controller.onCartUpdate(
                              totalQ: int.parse(cartItemModel.quantity.value),
                              cartItemModel: cartItemModel,
                              text: notesTEController.text);
                        } else {
                          controller.onDeleteCart(cartItemModel: cartItemModel);
                        }
                      },
                      child: Obx(() =>
                          int.parse(cartItemModel.quantity.value) == 1
                              ? Icon(Icons.delete,
                                  color: AppColors.redColor, size: 25)
                              : iconWidget(
                                  img: 'minus-icon.png',
                                  size: 25,
                                  color: AppColors.redColor))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Obx(() => Text(
                          cartItemModel.quantity.value.toString(),
                          style: heading1SemiBold(
                              color: AppColors.blackColor, fontSize: 18),
                        )),
                  ),
                  GestureDetector(
                      onTap: () {
                        cartItemModel.quantity.value =
                            (int.parse(cartItemModel.quantity.value) + 1)
                                .toString();
                        controller.onCartUpdate(
                            totalQ: int.parse(cartItemModel.quantity.value),
                            cartItemModel: cartItemModel,
                            text: notesTEController.text);
                      },
                      child: iconWidget(
                          img: 'add-icon.png',
                          size: 25,
                          color: AppColors.redColor)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget detailWidget({required CartItemModel cartItemModel}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 13, left: 10, right: 10, bottom: 13),
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
          Text(
            cartItemModel.note,
            style: heading1SemiBold(color: AppColors.blackColor, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget discountCode() {
    return const Padding(
      padding: EdgeInsets.only(top: 23, bottom: 20, left: 10, right: 10),
      /* child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Discount Code',style: headingBold(color: AppColors.blackColor,fontSize: 14),),
          CustomFilledButton(onPress: (){}, text: 'QRT56YG',backgroundColor: AppColors.redColor,width: 116,height: 29,radius: 15,fontSize: 13,)
        ],
      ),*/
    );
  }

  Widget slipWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: heading1(color: AppColors.blackColor, fontSize: 14),
              ),
              Obx(() => Text(
                    '€ ${controller.getCartModel.value.totalPurchase.toStringAsFixed(2)}',
                    style: heading1(color: AppColors.blackColor, fontSize: 14),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount amount',
                style: heading1(color: AppColors.blackColor, fontSize: 14),
              ),
              Text(
                '€ 0',
                style: heading1(color: AppColors.blackColor, fontSize: 14),
              ),
            ],
          ),
          Obx(
            () => controller.status.value == 'Pickup'
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery cost',
                        style:
                            heading1(color: AppColors.blackColor, fontSize: 14),
                      ),
                      Obx(() => Text(
                            '€ ${controller.getCartModel.value.deliveryFee}',
                            style: heading1(
                                color: AppColors.blackColor, fontSize: 14),
                          )),
                    ],
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: headingBold(color: AppColors.blackColor, fontSize: 14),
              ),
              Obx(() => Text(
                    '€ ${controller.status.value == 'Pickup' ? (controller.getCartModel.value.cartTotalAmount - double.parse(controller.getCartModel.value.deliveryFee)).toStringAsFixed(2) : controller.getCartModel.value.cartTotalAmount.toStringAsFixed(2)}',
                    style: heading1(color: AppColors.blackColor, fontSize: 14),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
