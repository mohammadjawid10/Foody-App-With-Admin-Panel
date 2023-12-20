import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:liefermars/utils/app_constants.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/internet_connection.dart';
import '../../utils/user_session_management.dart';


class SplashScreenController extends GetxController{
  String logoImage=Img.get('lief.png');
  String text='Splash Screen';
  final RxDouble splashLoading = 0.0.obs;

  RxBool isGermanLanguage=false.obs;

  UserSession userSession=UserSession();

  Timer? timer;
  InternetConnectionCheck internetConnectionCheck = InternetConnectionCheck();

  @override
  void onClose() {
    internetConnectionCheck.subscription.cancel();
    super.onClose();
  }
  @override
  void onInit() {
    internetConnectionCheck.getConnectivity();
    isGermanLanguageM();
    super.onInit();
    timer = Timer.periodic(
      const Duration(milliseconds: 50),
          (timer) {
        splashLoading.value += 0.025;
        if (splashLoading.value >= 1.0) {
          navigate();
          timer.cancel();
        }
      },
    );
  }

  Future<void> navigate() async{
      Get.offNamed(kDashboardScreen);
  }

  Future<void> isGermanLanguageM() async{
    isGermanLanguage.value=await userSession.isGermanLanguage();
    if(isGermanLanguage.value){
      Get.updateLocale(const Locale('de','GR'));
    }
  }

}