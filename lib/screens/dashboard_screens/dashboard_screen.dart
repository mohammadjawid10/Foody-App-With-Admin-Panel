import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/custom_widget/image_widget.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../controller/dashboard_screens_controller/dashboard_screen_controller.dart';
import '../../utils/app_colors.dart';
import 'delivery_list_screen.dart';
import 'filter_screen.dart';
import 'home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // @override
  final String tag = kDashBoardController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardScreenController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Obx(
              () => IndexedStack(
                index: controller.tabIndex.value,
                children: const [
                  DeliveryListScreen(),
                  HomeScreen(),
                  FilterScreen(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              unselectedItemColor: AppColors.blackColor,
              selectedItemColor: AppColors.redColor,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              iconSize: 23,
              selectedLabelStyle:
                  bodyMediumMedium(color: AppColors.redColor, fontSize: 10),
              unselectedLabelStyle:
                  bodyMediumMedium(color: AppColors.blackColor, fontSize: 10),
              elevation: 0,
              items: [
                _bottomNavigationBarItem(
                  icon: 'delivery-icon.png',
                  label: 'delivery'.tr,
                ),
                _bottomNavigationBarItem(
                  icon: 'pickup-icon.png',
                  label: 'pickup'.tr,
                ),
                _bottomNavigationBarItem(
                  icon: 'filter-icon.png',
                  label: 'Filter',
                ),
              ],
            ),
          ),
        );
      },
      tag: kDashBoardController,
    );
  }

  _bottomNavigationBarItem({required String icon, required String label}) {
    return BottomNavigationBarItem(
      activeIcon: iconWidget(img: icon, color: AppColors.redColor, size: 23),
      icon: iconWidget(img: icon, color: AppColors.blackColor, size: 23),
      label: label,
    );
  }
}
