import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import '../../custom_widget/custom_dialog.dart';
import '../../model/address_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/user_session_management.dart';
import '../dashboard_screens_controller/delivery_list_screen_controller.dart';
import '../dashboard_screens_controller/home_screen_controller.dart';

class CustomAppBarController extends GetxController{

  DeliveryListScreenController deliveryListScreenController=Get.find(tag: kDeliveryListController);
  HomeScreenController homeScreenController=Get.find(tag: kHomeController);

  String kGoogleApiKey='AIzaSyBwhHw0I3SUNIIMq0HaWkIx8BSbmHjooeA';

  double longitude=0.0;
  double latitude=0.0;
  final Mode mode = Mode.overlay;

  RxString city =''.obs, zip=''.obs;

  Position? latLng;
  RxString address=''.obs;

  UserSession userSession=UserSession();

  Rx<AddressModel> addressModel=AddressModel.empty().obs;

  RxString categoryId=''.obs;

  @override
  void onInit() {
    getUserAddressInformation();
    getCurrentPosition();
    super.onInit();
  }

  Future<void> getUserAddressInformation() async{
    addressModel.value = await userSession.getAddressInformation();
    log('------------------>>${addressModel.toString()}');

  }

  Future<void> getCurrentPosition() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomDialogs().showMessageDialog(title: 'Alert',
          description:'Location services are disabled, Please Turn on Location',
          type: DialogType.ERROR);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomDialogs().showMessageDialog(title: 'Alert',
            description:'Location permissions are denied',
            type: DialogType.ERROR);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      CustomDialogs().showMessageDialog(title: 'Alert',
          description:'Location permissions are permanently denied, we cannot request permissions.',
          type: DialogType.ERROR);
    }
    latLng=await Geolocator.getCurrentPosition();
    getAddressFromLatLong(latLng!);

  }

  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    address.value= '${place.street} ${place.postalCode} ${place.locality} ${place.country}';
    deliveryListScreenController.city.value=place.locality??'';
    deliveryListScreenController.zip.value=place.postalCode??'';
    homeScreenController.city.value=place.locality??'';
    homeScreenController.zip.value=place.postalCode??'';
    addressModel.value=AddressModel.forDelivery(street: place.street??'', yourAddress: place.administrativeArea??'', yourCity: place.locality??'', youZip: place.postalCode??'', floor: '', company: '', clientName: addressModel.value.clientName, yourPhone:  addressModel.value.yourPhone, yourEmail: addressModel.value.yourEmail);
    userSession.addressInformation(addressModel: addressModel.value);
    deliveryListScreenController.getDeviceTokenToSendNotification();
    homeScreenController.getDeviceTokenToSendNotification();

  }

  Future<void> displayPrediction(Prediction p) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    if(detail.result.formattedAddress!='') {
      address.value = detail.result.formattedAddress!;
    }
    latLng!.latitude!=detail.result.geometry!.location.lat;
    latLng!.longitude!=detail.result.geometry!.location.lng;
    latitude=detail.result.geometry!.location.lat;
    longitude=detail.result.geometry!.location.lng;
    latLng=Position(longitude: longitude, latitude: latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0);
    getAddressFromLatLong(latLng!);
  }

}