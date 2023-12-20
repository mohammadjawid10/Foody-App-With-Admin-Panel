import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/utils/app_constants.dart';
import 'package:liefermars/utils/app_language.dart';
import 'package:liefermars/utils/route_management.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey='pk_test_51MuMjcHK08LMGtNrCtgv5nv9vByD16ZFwLPpOsdfURV5CA3Kmc8UqIyB8XyNyCjfSaEp5Vm5BPyssa0KA1EuKgVS00mfcaiFih';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale:const Locale('en', 'UK'),
      title: kAppName,
      getPages: RouteGenerator.getPages(),
      initialRoute: kSplashScreen,
    );
  }
}
