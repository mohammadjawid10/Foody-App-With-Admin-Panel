import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_screens_controller/splash_screen_controller.dart';


class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.navigate();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE02373),
        body:
        Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(controller.logoImage),
        )),

      ),
    );
  }
}
