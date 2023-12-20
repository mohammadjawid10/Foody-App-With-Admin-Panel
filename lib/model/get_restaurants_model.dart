import 'package:liefermars/model/restaurant_model.dart';

import 'category_model.dart';

class GetRestaurantModel {
  List<RestaurantModel> restaurantList=[];
  String pagination='';
  int totalData=-1;
  List<CategoryModel> categoryList=[];

  GetRestaurantModel({required this.restaurantList, required this.pagination, required this.totalData, required this.categoryList});

  GetRestaurantModel.empty();

  GetRestaurantModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      restaurantList = <RestaurantModel>[];
      json['data'].forEach((v) {
        restaurantList.add(RestaurantModel.fromJson(v));
      });
    }
    pagination = json['pagination']??'';
    totalData = json['total_data']??-1;
    if (json['cat'] != null) {
      categoryList = <CategoryModel>[];
      json['cat'].forEach((v) {
        categoryList.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = restaurantList.map((v) => v.toJson()).toList();
    data['pagination'] = pagination;
    data['total_data'] = totalData;
    data['cat'] = categoryList.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'GetRestaurantModel{restaurantList: $restaurantList, pagination: $pagination, totalData: $totalData, categoryList: $categoryList}';
  }
}

