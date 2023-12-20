import 'package:liefermars/model/category_model.dart';
import 'package:liefermars/model/restauant_review_model.dart';
import 'package:liefermars/model/restaurant_info_model.dart';
import 'package:liefermars/model/restaurant_rest_timming_model.dart';

import 'menu_model.dart';

class GetRestaurantMenuModel {
  String restId='';
  String restName='';
  String restEmail='';
  String restLat='';
  String restLong='';
  String restLogo='';
  String deliveryCost='';
  String minOrderAmount='';
  String overallRating='';
  int totalReviews=-1;
  String testWebsite='';
  String restZip='';
  String restCity='';
  String restAddress='';
  String restOwner='';
  String restaurantCode='';
  String delivery='';
  String pickup='';
  List<CategoryModel> listOfCategoryModel=[];
  List<MenuModel> listOfMenuModel=[];
  List<RestaurantReviewModel> listOfRestaurantReview=[];
  List<RestaurantTimingModel> listOfRestTiming=[];
  RestaurantInfoModel restaurantInfoModel=RestaurantInfoModel.empty();

  GetRestaurantMenuModel.empty();

  GetRestaurantMenuModel.reqParameter(
      {required this.restId,
      required this.restName,
      required this.restEmail,
      required this.restLat,
      required this.restLong,
      required this.restLogo,
      required this.deliveryCost,
      required this.minOrderAmount,
      required this.overallRating,
      required this.totalReviews,
      required this.testWebsite,
      required this.restZip,
      required this.restCity,
      required this.restAddress,
      required this.restOwner,
      required this.restaurantCode,
      required this.delivery,
      required this.pickup,
      required this.listOfCategoryModel,
      required this.listOfMenuModel,
      required this.listOfRestaurantReview,
      required this.listOfRestTiming,
  });

  GetRestaurantMenuModel.fromJson(Map<String, dynamic> json) {
    restId = json['restid']??'';
    restName = json['restname']??'';
    restEmail = json['restemail']??'';
    restLat = json['restlat']??'';
    restLong = json['restlong']??'';
    restLogo = json['restlogo']??'';
    deliveryCost = json['deliverycost']??'';
    minOrderAmount = json['minorderamount']??'';
    overallRating = json['overall_rating']??'';
    totalReviews = json['total_reviews']??-1;
    testWebsite = json['testwebsite']??'';
    restZip = json['restzip']??'';
    restCity = json['restcity']??'';
    restAddress = json['restaddress']??'';
    restOwner = json['restowner']??'';
    restaurantCode = json['resturent_code']??'';
    delivery = json['delivery']??'';
    pickup = json['pickup']??'';
    if (json['catarr'] != null) {
      listOfCategoryModel = <CategoryModel>[];
      json['catarr'].forEach((v) {
        listOfCategoryModel.add(CategoryModel.fromJson(v));
      });
    }
    if (json['menuarr'] != null) {
      listOfMenuModel = <MenuModel>[];
      json['menuarr'].forEach((v) {
        listOfMenuModel.add(MenuModel.fromJson(v));
      });
    }
    if (json['reviewarr'] != null) {
      listOfRestaurantReview = <RestaurantReviewModel>[];
      if(json['reviewarr'] is List) {
        json['reviewarr'].forEach((v) {
          listOfRestaurantReview.add(RestaurantReviewModel.fromJson(v));
        });
      }
    }
    if (json['resttimingsarr'] != null) {
      listOfRestTiming = <RestaurantTimingModel>[];
      json['resttimingsarr'].forEach((v) {
        listOfRestTiming.add(RestaurantTimingModel.fromJson(v));
      });
    }
    restaurantInfoModel =  RestaurantInfoModel.fromJson(json['restinfo']??{});
  }

  @override
  String toString() {
    return 'GetRestaurantMenuModel{restId: $restId, restName: $restName, restEmail: $restEmail, restLat: $restLat, restLong: $restLong, restLogo: $restLogo, deliveryCost: $deliveryCost, minOrderAmount: $minOrderAmount, overallRating: $overallRating, totalReviews: $totalReviews, testWebsite: $testWebsite, restZip: $restZip, restCity: $restCity, restAddress: $restAddress, restOwner: $restOwner, restaurantCode: $restaurantCode, delivery: $delivery, pickup: $pickup, listOfCategoryModel: $listOfCategoryModel, listOfMenuModel: $listOfMenuModel, listOfRestaurantReview: $listOfRestaurantReview, listOfRestTiming: $listOfRestTiming, restaurantInfoModel: $restaurantInfoModel}';
  }
}



