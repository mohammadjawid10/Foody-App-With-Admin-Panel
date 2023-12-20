import 'my_orders_model.dart';

class GetOrderModel {
  List<MyOrdersModel> myOrders=[];
  int showingTotalOrders=0;
  int totalOrders=0;

  GetOrderModel.empty();

  GetOrderModel(
      {required this.myOrders,
        required this.showingTotalOrders,
        required this.totalOrders});

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['my_orders'] != null) {
      myOrders = <MyOrdersModel>[];
      json['my_orders'].forEach((v) {
        myOrders.add(MyOrdersModel.fromJson(v));
      });
    }
    showingTotalOrders = json['showingtotalorders']??0;
    totalOrders = json['totalorders']??0;
  }

  @override
  String toString() {
    return 'GetOrderModel{myOrders: $myOrders, showingTotalOrders: $showingTotalOrders, totalOrders: $totalOrders}';
  }
}


