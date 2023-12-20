import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/dashboard_screens_controller/restaurant_detail_screen_controller.dart';
import 'package:liefermars/utils/app_constants.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
import '../../custom_widget/custom_dialog.dart';
import '../../custom_widget/custom_filled_button.dart';
import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../model/menu_model_by_category.dart';
import '../../utils/app_colors.dart';

class RestaurantDetailScreen extends GetView<RestaurantDetailScreenController> {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: controller.scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: Get.height,
              child: Obx(
                () => controller.listOfCategoryModel.isNotEmpty
                    ? VerticalScrollableTabView(
                        autoScrollController: controller.autoScrollController,
                        scrollbarThumbVisibility: false,
                        tabController: controller.tabController.value,
                        listItemData: controller.listOfCategoryModel,
                        verticalScrollPosition: VerticalScrollPosition.begin,
                        eachItemChild: (object, index) => SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 40,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.only(
                                      top: 13, left: 10, right: 10, bottom: 13),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.getRestaurantMenuModel
                                            .listOfMenuModel[index].catName,
                                        style: heading1SemiBold(
                                            color: AppColors.blackColor,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        controller.getRestaurantMenuModel
                                            .listOfMenuModel[index].cateDesc,
                                        style: heading1(
                                            color: AppColors.blackColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                for (int i = 0;
                                    i <
                                        controller
                                            .getRestaurantMenuModel
                                            .listOfMenuModel[index]
                                            .menuModelByCategory
                                            .length;
                                    i++)
                                  // TODO: Fitna gets called here
                                  itemDetailWidget(
                                    menuModel: controller
                                        .getRestaurantMenuModel
                                        .listOfMenuModel[index]
                                        .menuModelByCategory[i],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        slivers: [
                          SliverAppBar(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            floating: true,
                            snap: true,
                            title: Padding(
                              padding: const EdgeInsets.only(left: 14, top: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: iconWidget(
                                          img: 'back-button.png', size: 20))),
                            ),
                            automaticallyImplyLeading: false,
                          ),
                          SliverAppBar(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            automaticallyImplyLeading: false,
                            expandedHeight: controller.maxHeaderHeight,
                            flexibleSpace: FlexibleSpaceBar(
                              background: SafeArea(child: _topImageWidget()),
                              collapseMode: CollapseMode.pin,
                            ),
                          ),
                          SliverPersistentHeader(
                            delegate: SliverHeaderDelegateComponent(
                              expandedHeight: 50,
                              sliverWidget: Container(
                                color: Colors.white,
                                child: _tabBarWidget(),
                              ),
                            ),
                            pinned: true,
                          ),
                        ],
                      )
                    : controller.listOfCategoryModel.isEmpty &&
                            controller.isLoad.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFE02373),
                            ),
                          )
                        : SizedBox(
                            child: Center(
                              child: Text(
                                'No Record',
                                style: heading1SemiBold(
                                    color: AppColors.blackColor, fontSize: 15),
                              ),
                            ),
                          ),
              ),
            ),
            Positioned(bottom: 20, left: 21, right: 21, child: addCartButton()),
          ],
        ),
      ),
    );
  }

  Widget _topImageWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 135,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              image: DecorationImage(
                  image: controller.restaurantModel.banner != ''
                      ? CachedNetworkImageProvider(
                          controller.restaurantModel.banner)
                      : AssetImage(Img.get('white.png')) as ImageProvider,
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 7),
          child: Row(
            children: [
              Text(
                controller.restaurantModel.name,
                style: headingBold(fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(kRestaurantInformationScreen,
                        arguments: controller.getRestaurantMenuModel);
                  },
                  child: iconWidget(
                    img: 'info-icon.jpeg',
                    size: 20,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.listOfReviews.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              Get.toNamed(kRestaurantReviewScreen, arguments: [
                                controller.listOfReviews,
                                controller.restaurantModel.name
                              ]);
                            },
                            child: Row(
                              children: [
                                Text(
                                  controller.restaurantModel.overallRating,
                                  style: headingBold(
                                      color: AppColors.blackColor,
                                      fontSize: 12),
                                ),
                                RatingBar.builder(
                                  initialRating: double.parse(
                                      controller.restaurantModel.overallRating),
                                  itemSize: 15,
                                  tapOnlyMode: true,
                                  updateOnDrag: true,
                                  ignoreGestures: true,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => iconWidget(
                                      img: 'star-icon.png',
                                      size: 15,
                                      color: AppColors.redColor),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                Obx(() => Text(
                                      ' ${controller.listOfReviews.length} rating(s)',
                                      style: headingBold(
                                          color: AppColors.blackColor
                                              .withOpacity(0.3),
                                          fontSize: 12),
                                    )),
                              ],
                            ),
                          )
                        : SizedBox(),
                    Row(
                      children: [
                        Obx(
                          () => FilledButton(
                            onPressed: () {
                              controller.status.value = 'Delivery';
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor:
                                    controller.status.value == 'Delivery'
                                        ? AppColors.redColor
                                        : const Color(0xFFF9F1F1),
                                minimumSize: const Size(100, 30),
                                elevation: controller.status.value == 'Delivery'
                                    ? 7
                                    : 2),
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
                                backgroundColor:
                                    controller.status.value == 'Pickup'
                                        ? AppColors.redColor
                                        : const Color(0xFFF9F1F1),
                                minimumSize: const Size(100, 30),
                                elevation: controller.status.value == 'Pickup'
                                    ? 7
                                    : 2),
                            child: Text(
                              'Pickup',
                              style: headingBold(
                                  color: controller.status.value == 'Pickup'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  /*Icon(Icons.favorite,color: AppColors.redColor,size: 20),
                  const SizedBox(width: 8),*/
                  CachedNetworkImage(
                    height: 58,
                    width: 58,
                    fit: BoxFit.fill,
                    imageUrl: controller.restaurantModel.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabBarWidget() {
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            Divider(
              color: AppColors.blackColor.withOpacity(0.3),
            ),
            Expanded(
              child: Obx(
                () => TabBar(
                    isScrollable: true,
                    controller: controller.tabController.value,
                    unselectedLabelColor: Colors.black,
                    labelColor: const Color(0xFFE02373),
                    indicatorColor: Colors.transparent,
                    onTap: (index) {
                      // VerticalScrollableTabBarStatus.setIndex(index);
                    },
                    tabs: controller.listOfCategoryModel.map((e) {
                      return Tab(text: e.title);
                    }).toList()),
              ),
            ),
            Divider(
              color: AppColors.blackColor.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDetailWidget({required MenuModelByCategory menuModel}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () async {
          if (controller.restaurantModel.isOpen == 1) {
            // TODO: Another Fitna
            log('Another Fitna');
            bool resp = await Get.toNamed(
              kProductInfoScreen,
              arguments: menuModel,
            );
            if (resp) {
              controller.getCartData();
            }
          } else if (controller.restaurantModel.isOpen == 0) {
            CustomDialogs().productInfoDialog(
                title: 'Message',
                yesFunction: () {},
                description: 'Closed For Delivery');
          }
        },
        child: Container(
          width: Get.width,
          padding:
              const EdgeInsets.only(left: 23, bottom: 5, top: 8, right: 12),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(
                width: 1,
                color: AppColors.lighterGrey,
              ),
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
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuModel.name,
                          style: heading1SemiBold(
                              color: AppColors.blackColor, fontSize: 15),
                        ),
                        Text(
                          '€ ${menuModel.price}',
                          style: headingBold(
                              color: AppColors.redColor, fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          menuModel.description,
                          style: heading1(
                            color: AppColors.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    height: 64,
                    width: 64,
                    fit: BoxFit.fill,
                    imageUrl: menuModel.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const SizedBox(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFilledButton(
                    onPress: () {
                      CustomDialogs().productInfoDialog(
                          title: 'Allergies',
                          yesFunction: () {},
                          description: menuModel.allergies);
                    },
                    text: 'Product info',
                    radius: 15,
                    width: 103,
                    height: 27,
                    fontSize: 12,
                    textColor: AppColors.blackColor,
                    backgroundColor: AppColors.whiteColor,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (controller.restaurantModel.isOpen == 1) {
                          // TODO: Second Fitna
                          log('Second Fitna');
                          bool resp = await Get.toNamed(
                            kProductInfoScreen,
                            arguments: menuModel,
                          );
                          if (resp) {
                            controller.getCartData();
                          }
                        } else if (controller.restaurantModel.isOpen == 0) {
                          CustomDialogs().productInfoDialog(
                              title: 'Message',
                              yesFunction: () {},
                              description: 'Closed For Delivery');
                        }
                      },
                      child: iconWidget(
                          img: 'add-icon.png',
                          size: 25,
                          color: AppColors.blackColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addCartButton() {
    return GestureDetector(
      onTap: () async {
        bool resp = await Get.toNamed(kOrderViewScreen, arguments: [
          controller.getCartModel.value,
          controller.status.value
        ]);
        if (resp) {
          controller.getCartData();
        }
      },
      child: Container(
        width: Get.width,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
            Icon(
              Icons.shopping_cart_sharp,
              color: AppColors.whiteColor,
              size: 17,
            ),
            Text(
              'View Orders',
              style: headingBold(color: AppColors.whiteColor, fontSize: 15),
            ),
            Obx(() => Text(
                  '${controller.getCartModel.value.totalPurchase.toStringAsFixed(2)} €',
                  style: headingBold(color: AppColors.whiteColor, fontSize: 15),
                )),
            CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.blackColor.withOpacity(0.4),
              child: Obx(() => Text(
                    '${controller.getCartModel.value.items.length}',
                    style:
                        headingBold(color: AppColors.whiteColor, fontSize: 13),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class SliverHeaderDelegateComponent extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Widget sliverWidget;

  const SliverHeaderDelegateComponent(
      {required this.expandedHeight, required this.sliverWidget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => SizedBox(
        height: expandedHeight + expandedHeight / 2,
        child: sliverWidget,
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
