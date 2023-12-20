import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/address_model.dart';
import '../model/payment_model.dart';


class UserSession{

  UserSession._internal();
  static final UserSession _instance = UserSession._internal();
  factory UserSession(){
    return _instance;
  }
  static const String USER_DATA = "USERDATA";
  static const String USER_DATA_PICK = "USERDATAPICK";
  static const String IS_LOGIN = "IS_LOGIN";
  static const String IS_GERMAN_LANGUAGE = "IS_GERMAN_LANGUAGE";
  static const String IS_REMEBER="IS_REMEMBER";
  static const String IS_PAYMENT_TYPE="IS_PAYMENT_TYPE";
  static const String IS_FIRST_TIME_LOGIN="IS_FIRST_TIME_LOGIN";



  Future<void> paymentInformation({required PaymentModel paymentModel}) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString(IS_PAYMENT_TYPE,jsonEncode(paymentModel.toJsonForSession()));
  }

  Future<PaymentModel> getPaymentInformation() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    return PaymentModel.fromSessionData(jsonDecode(preference.getString(IS_PAYMENT_TYPE)??'{}'));
  }

  Future<void> addressInformation({required AddressModel addressModel}) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString(USER_DATA,jsonEncode(addressModel.toJsonForSession()));
  }

  Future<AddressModel> getAddressInformation() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    return AddressModel.fromSessionData(jsonDecode(preference.getString(USER_DATA)??'{}'));
  }

  Future<void> addressInformationForPick({required AddressModel addressModel}) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString(USER_DATA_PICK,jsonEncode(addressModel.toJsonForSessionPickup()));
  }

  Future<AddressModel> getAddressInformationForPick() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    return AddressModel.fromSessionDataPickup(jsonDecode(preference.getString(USER_DATA_PICK)??'{}'));
  }

  Future<void> setLogin() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool(IS_LOGIN,true);
  }

  Future<bool> isUserLoggedIn()async{
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(IS_LOGIN)??false;
  }

  Future<void> setLanguage(bool isLang) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool(IS_GERMAN_LANGUAGE,isLang);
  }

  Future<bool> isGermanLanguage()async{
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(IS_GERMAN_LANGUAGE)??false;
  }

  Future<void> isRememberMe(String email) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString(IS_REMEBER,email);
  }
  Future<String> getEmail() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(IS_REMEBER)??'';
  }

  Future<bool> isUserFirstLoggedIn()async{
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(IS_FIRST_TIME_LOGIN)??true;
  }

  Future<void> logOut()async{
    final preference = await SharedPreferences.getInstance();
    preference.clear();
    preference.setBool(IS_FIRST_TIME_LOGIN, false);
  }

}