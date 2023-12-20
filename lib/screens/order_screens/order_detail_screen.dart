import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/order_screens_controller/order_detail_screen_controller.dart';
import 'package:liefermars/utils/app_colors.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/custom_textfield.dart';
import '../../custom_widget/image_widget.dart';
import '../../model/order_item_detail_model.dart';

class OrderDetailScreen extends GetView<OrderDetailScreenController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 60),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: iconWidget(img: 'back-button.png', size: 21),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'Order details',
                              style: heading1SemiBold(
                                  color: AppColors.blackColor, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                    orderDetailContainer(
                        image: controller.myOrdersModel.restaurantLogo,
                        title: controller.myOrdersModel.restaurantName,
                        address:
                            '${controller.myOrdersModel.house} \n${controller.myOrdersModel.zip} ${controller.myOrdersModel.city.split(' ')[0]}',
                        date: controller.myOrdersModel.createdAt.split(' ')[0],
                        orderType: controller.myOrdersModel.shippingType,
                        orderNum: controller.getOrderModel.value.code,
                        paymentType:
                            controller.getOrderModel.value.paymentType),
                    const SizedBox(
                      height: 35,
                    ),
                    for (int i = 0;
                        i <
                            controller.getOrderModel.value.items
                                .orderItemDetailModel.length;
                        i++)
                      headingItemWidget(controller
                          .getOrderModel.value.items.orderItemDetailModel[i]),
                    calculationWidget(
                        label: 'Subtutel',
                        price: controller.getOrderModel.value.subtotal
                            .toStringAsFixed(2)),
                    calculationWidget(
                        label: 'Delivery  Costs',
                        price: controller.getOrderModel.value.deliveryFee),
                    calculationWidget(
                        label: 'Totel',
                        price: controller.getOrderModel.value.orderGrandTotal),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.myOrdersModel.reviewHashKey != ''
                        ? Align(
                            alignment: Alignment.topRight,
                            child: CustomFilledButton(
                                onPress: () {
                                  Get.toNamed(kSubmitReviewScreen, arguments: [
                                    controller.myOrdersModel.reviewHashKey,
                                    controller.myOrdersModel.orderId
                                  ]);
                                },
                                text: 'Review',
                                backgroundColor: AppColors.redColor,
                                width: 115,
                                height: 31,
                                radius: 10,
                                fontSize: 16))
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget orderDetailContainer(
      {required String image,
      required String title,
      required String address,
      required String date,
      required String orderNum,
      required String orderType,
      required String paymentType}) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 45,
            width: 45,
            fit: BoxFit.fill,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
            errorWidget: (context, url, error) => const SizedBox(),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: heading1SemiBold(
                      color: AppColors.blackColor, fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    address,
                    style: heading1(color: AppColors.blackColor, fontSize: 10),
                  ),
                ),
                Text(
                  'Date: $date',
                  style: heading1(color: AppColors.blackColor, fontSize: 14),
                ),
                Text(
                  'Order#: $orderNum',
                  style: headingBold(color: AppColors.blackColor, fontSize: 14),
                ),
                Text(
                  'Order type: $orderType',
                  style: headingBold(color: AppColors.blackColor, fontSize: 14),
                ),
                Text(
                  'Payment Method: $paymentType',
                  style: headingBold(color: AppColors.blackColor, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget headingItemWidget(OrderItemDetailModel orderItemDetailModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding:
            const EdgeInsets.only(top: 12, left: 10, right: 10, bottom: 30),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderItemDetailModel.name,
                      style: heading1SemiBold(
                          color: AppColors.blackColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    for (int i = 0; i < orderItemDetailModel.addons.length; i++)
                      Text(
                        '${i + 1} ${orderItemDetailModel.addons[i].name}  ${orderItemDetailModel.addons[i].amount}€',
                        style:
                            heading1(color: AppColors.blackColor, fontSize: 12),
                      ),
                    for (int i = 0;
                        i < orderItemDetailModel.multiAddons.length;
                        i++)
                      Text(
                        '${i + 1} ${orderItemDetailModel.multiAddons[i].name}  ${orderItemDetailModel.multiAddons[i].amount}€',
                        style:
                            heading1(color: AppColors.blackColor, fontSize: 12),
                      ),
                  ],
                )),
                Text(
                  orderItemDetailModel.itemTotal,
                  style: heading1SemiBold(
                      color: AppColors.blackColor, fontSize: 15),
                ),
              ],
            ),
            notesWidget(orderItemDetailModel)
          ],
        ),
      ),
    );
  }

  Widget notesWidget(OrderItemDetailModel orderItemDetailModel) {
    controller.textEditingController.text = orderItemDetailModel.note;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            'Notes',
            style: bodyMediumMedium(color: AppColors.blackColor, fontSize: 16),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: CustomTextField(
              controller: controller.textEditingController,
              hintText: orderItemDetailModel.note,
              radius: 15,
              height: 29,
              enabled: false,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDetailContainer(
      {required String index, required String item, required String price}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: Get.width,
        padding:
            const EdgeInsets.only(top: 12, left: 10, right: 10, bottom: 30),
        decoration: BoxDecoration(
            color: AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.blackColor, width: 1),
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor,
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 3.0,
                  spreadRadius: 2),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              index,
              style:
                  bodyMediumMedium(color: AppColors.blackColor, fontSize: 12),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                item,
                style:
                    bodyMediumMedium(color: AppColors.blackColor, fontSize: 12),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                iconWidget(img: 'euro-icon.png', size: 14),
                Text(
                  '   $price',
                  style: bodyMediumMedium(
                      color: AppColors.blackColor, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget calculationWidget({required String label, required String price}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style:
                  bodyMediumMedium(color: AppColors.blackColor, fontSize: 12),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconWidget(img: 'euro-icon.png', size: 14),
              Text(
                '   $price',
                style:
                    bodyMediumMedium(color: AppColors.blackColor, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
