import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liefermars/model/get_restaurant_menu_model.dart';

class RestaurantInformationScreenController extends GetxController{

  GetRestaurantMenuModel getRestaurantMenuModel=GetRestaurantMenuModel.empty();

  Completer<GoogleMapController> gController = Completer<GoogleMapController>();
  GoogleMapController? googleMapController;

  List<Marker> markers=[];

  List<Marker> listOfMarkers=[
  ];

  @override
  void onInit() {
    getRestaurantMenuModel=Get.arguments;
    loadData();
    super.onInit();
  }


  Future<void> loadData() async{
    listOfMarkers.add(Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(double.parse(getRestaurantMenuModel.restLat), double.parse(getRestaurantMenuModel.restLong)),
      infoWindow: InfoWindow(title: getRestaurantMenuModel.restName),

    ));
    markers.addAll(listOfMarkers);
  }
  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

}