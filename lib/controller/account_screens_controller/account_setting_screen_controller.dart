import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class AccountSettingScreenController extends GetxController{

  void onChangePasswordTap(){
    Get.toNamed(kChangePasswordScreen);
  }
  void onDeleteTap(){
    Get.toNamed(kDeleteAccountScreen);
  }
}