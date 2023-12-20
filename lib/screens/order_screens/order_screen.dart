import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/order_screens_controller/orders_screen_controller.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../custom_widget/image_widget.dart';
import '../../model/my_orders_model.dart';
import '../../utils/app_colors.dart';

class OrdersScreen extends GetView<OrdersScreenController> {
  const OrdersScreen({super.key});

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
                            child:
                                iconWidget(img: 'back-button.png', size: 21)),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "order".tr,
                              style: heading1SemiBold(
                                  color: AppColors.blackColor, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    for (int i = 0;
                        i < controller.getOrderModel.value.myOrders.length;
                        i++)
                      orderDetailContainer(
                          myOrdersModel:
                              controller.getOrderModel.value.myOrders[i]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget orderDetailContainer({required MyOrdersModel myOrdersModel}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(kOrderDetailScreen, arguments: myOrdersModel);
        },
        child: Container(
          width: Get.width,
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: AppColors.blackColor),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor,
                offset: const Offset(0.0, 5.0),
                blurRadius: 3.0,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                height: 60,
                width: 50,
                fit: BoxFit.fill,
                imageUrl: myOrdersModel.restaurantLogo,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
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
                      myOrdersModel.restaurantName,
                      style: heading1SemiBold(
                          color: AppColors.blackColor, fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        'Address: ${myOrdersModel.address} ${myOrdersModel.house} ${myOrdersModel.zip} ${myOrdersModel.city}',
                        style:
                            heading1(color: AppColors.blackColor, fontSize: 10),
                      ),
                    ),
                    Text(
                      'Date: ${myOrdersModel.createdAt.split(' ')[0]}',
                      style:
                          heading1(color: AppColors.blackColor, fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
