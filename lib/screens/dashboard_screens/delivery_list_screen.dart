import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/controller/dashboard_screens_controller/delivery_list_screen_controller.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/custom_widget/image_widget.dart';
import 'package:liefermars/model/restaurant_model.dart';
import 'package:liefermars/utils/app_colors.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../custom_widget/custom_app_bar.dart';
import '../../custom_widget/custom_navigation_drawer.dart';


class DeliveryListScreen extends GetView<DeliveryListScreenController> {
  const DeliveryListScreen({super.key});

  @override
  final String tag=kDeliveryListController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: SizedBox(
        height: Get.height,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
               SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                floating: true,
                //snap: true,
                automaticallyImplyLeading: false,
                title: CustomAppBar(onTap: (){
                  controller.scaffoldKey.currentState!.openDrawer();
                  FocusScope.of(context).requestFocus(FocusNode());
                },),
              ),
              Obx(
                ()=> controller.listOfRestaurant.isNotEmpty?SliverAppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  floating: true,
                  //snap: true,
                  automaticallyImplyLeading: false,
                  title: Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: controller.listOfRestaurant.isNotEmpty?Text('Order  From ${controller.listOfRestaurant.length} Restaurant',style: heading1SemiBold(fontSize: 19,color: AppColors.blackColor),textAlign: TextAlign.center,):const SizedBox()
                    ),
                  ),
                ):SliverToBoxAdapter(),
              ),
            ];
          },
          body:  _getBody(),
        ),
      ),
      drawer: const CustomNavigationDrawer(),
    );
  }
  Widget _getBody(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Obx(
            ()=> controller.listOfCategoryModel.length>1?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Divider(color: AppColors.blackColor.withOpacity(0.3),),
                Obx(
                      ()=> TabBar(
                      isScrollable: true,
                      controller: controller.tabController.value,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.black,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        for(int i=0;i<controller.listOfCategoryModel.length;i++)
                          tabContainer(title: controller.listOfCategoryModel[i].title,id: controller.listOfCategoryModel[i].id),
                      ]),
                ),
                Divider(color: AppColors.blackColor.withOpacity(0.3),),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: listOfRestaurant(),
            ),
          ],
        ):SizedBox(child: Center(
              child: Text('No Record',style: heading1SemiBold(color: AppColors.blackColor,fontSize: 15),),
            ),),
      ),
    );
  }

  Widget tabContainer({required String title,required String id}){
    return  Tab(
      height: 30,
      child: GestureDetector(
          onTap: (){
            controller.onTabChange(catId: id);
          },
          child: Center(child: Text(title,style: bodyMediumMedium(fontSize: 16,color: id==controller.categoryId.value?const Color(0xFFE02373):Colors.black),))),
    );

  }

  Widget listOfRestaurant(){
    return SingleChildScrollView(
      child: Column(
        children: [
          for(int i=0;i<controller.listOfRestaurant.length;i++)
            controller.listOfRestaurant[i].delivery=='1'? restaurantDetailWidget(restaurantModel: controller.listOfRestaurant[i]):const SizedBox(),
        ],
      ),
    );
  }

  Widget restaurantDetailWidget({required RestaurantModel restaurantModel}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () async{
          Get.toNamed(kRestaurantDetailScreen,arguments: [restaurantModel,'Delivery']);
         /* if(restaurantModel.isOpen==1){
            Get.toNamed(kRestaurantDetailScreen,arguments: [restaurantModel,'Delivery']);
          }else if(restaurantModel.isOpen==0){
            CustomDialogs().productInfoDialog(title: 'Message', yesFunction: (){}, description: 'Closed For Delivery');

          }*/

        },
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.blackColor),
              boxShadow: [
                BoxShadow(
                    color: AppColors.greyColor,
                    offset: const Offset(0.0, 5.0),
                    blurRadius: 3.0,
                    spreadRadius: 4
                ),
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                    image: DecorationImage(image: restaurantModel.banner!=''?CachedNetworkImageProvider(restaurantModel.banner):AssetImage(Img.get('white.png')) as ImageProvider,fit: BoxFit.cover)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(restaurantModel.name,style: headingBold(fontSize: 16),),
                              Text(restaurantModel.categories,style: heading1(fontSize: 16),),
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          height: 62,
                          width:62,
                          imageUrl: restaurantModel.image,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        restaurantModel.isOpen==0? Expanded(child: Text('closedfordelivery'.tr,style: heading1SemiBold(fontSize: 15,color: AppColors.redColor),)):
                            Row(children: [
                              Row(
                                children: [
                                  iconWidget(img: 'delivery-icon.png',size: 22),
                                  const SizedBox(width: 3,),
                                  Text(restaurantModel.deliveryFee,style: heading1(fontSize: 12,color: AppColors.blackColor),),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 27),
                                child: Row(
                                  children: [
                                    iconWidget(img: 'watch-icon.png',size: 22),
                                    const SizedBox(width: 3,),
                                    Text(restaurantModel.deliveryTime,style: heading1(fontSize: 12,color: AppColors.blackColor),),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  iconWidget(img: 'bag-icon.png',size: 22),
                                  const SizedBox(width: 3,),
                                  Text('Min € ${restaurantModel.minOrder}',style: heading1(fontSize: 12,color: AppColors.blackColor),),
                                ],
                              ),
                            ],),
                        Container(
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 4,bottom: 4),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.greyColor,
                                    offset: const Offset(0.0, 5.0),
                                    blurRadius: 3.0,
                                    spreadRadius: 4
                                ),
                              ]
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                iconWidget(img: 'star-icon.png',size: 14,color: AppColors.redColor),
                                Text(restaurantModel.overallRating,style: heading1(fontSize: 11),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
