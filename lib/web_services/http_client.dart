import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:liefermars/model/get_my_review_model.dart';
import 'package:liefermars/model/option_model.dart';
import '../model/checkout_model.dart';
import '../model/get_cart_model.dart';
import '../model/get_load_addons_model.dart';
import '../model/get_menu_option_model.dart';
import '../model/get_order_detail_model.dart';
import '../model/get_order_model.dart';
import '../model/get_restaurant_menu_model.dart';
import '../model/get_restaurants_model.dart';
import '../model/get_review_data_model.dart';
import '../model/response_model.dart';
import '../model/time_model.dart';
import '../model/user_info_model.dart';

class HTTPClient {
  HTTPClient._internal();
  factory HTTPClient() {
    return _instance;
  }
  static const int _requestTimeOut = 15;
  static final HTTPClient _instance = HTTPClient._internal();

  Future<ResponseModel> postRequest(
      {required String url,
      dynamic requestBody,
      bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
            body: requestBody,
          )
          .timeout(const Duration(seconds: _requestTimeOut));
      ResponseModel responseModel =
          ResponseModel.fromJson(json.decode(response.body));
      return responseModel;
    } on TimeoutException {
      return Future.value(ResponseModel.named(
          statusCode: 408, statusDescription: "Request TimeOut", data: ""));
    } on SocketException {
      return Future.value(ResponseModel.named(
          statusCode: 400, statusDescription: "Bad Request", data: ""));
    } catch (e) {
      return Future.value(ResponseModel.named(
          statusCode: 500, statusDescription: "Server Error", data: ""));
    }
  }

  Future<ResponseModel> postMultipartProfileUpdateRequest(
      {required String url, required UserInfoModel userInfoModel}) async {
    try {
      Map<String, String> customHeader = await _getHeaders();
      if (customHeader.isNotEmpty &&
          customHeader.entries.first.value.isNotEmpty) {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(url));

        request.headers.addAll(customHeader);
        request.fields['fname'] = userInfoModel.firstname;
        request.fields['lname'] = userInfoModel.lastname;
        request.fields['email'] = userInfoModel.email;
        request.fields['zip'] = userInfoModel.zip;
        request.fields['phone'] = userInfoModel.phone;
        request.fields['gender'] = userInfoModel.gender;
        request.fields['sessid'] = userInfoModel.sessionId;
        request.fields['city'] = userInfoModel.city;
        request.fields['saveProfile'] = '1';
        if (userInfoModel.profileImg != 'Choose File' &&
            userInfoModel.profileImg.contains('https://api.liefermars.de') ==
                false) {
          request.files.add(await http.MultipartFile.fromPath(
              'profile_img', userInfoModel.profileImg));
        }
        http.StreamedResponse streamedResponse = await request.send();
        http.Response httpResponse =
            await http.Response.fromStream(streamedResponse);
        ResponseModel response =
            ResponseModel.fromJson(jsonDecode(httpResponse.body));
        return Future.value(response);
      } else {
        return Future.value(ResponseModel.named(
            statusCode: 404,
            statusDescription: "Client authentication failed",
            data: ""));
      }
    } on TimeoutException {
      return Future.value(ResponseModel.named(
          statusCode: 408,
          statusDescription: "Request TimeOut",
          data: "Request TimeOut"));
    } on SocketException {
      return Future.value(ResponseModel.named(
          statusCode: 400,
          statusDescription: "Bad Request",
          data: "Bad Request"));
    } catch (e) {
      return Future.value(ResponseModel.named(
          statusCode: 500,
          statusDescription: "Server Error",
          data: "Server Error"));
    }
  }

  Future<CheckOutModel> postRequestForCheckOut(
      {required String url,
      dynamic requestBody,
      bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
            body: requestBody,
          )
          .timeout(const Duration(seconds: _requestTimeOut));
      CheckOutModel responseModel =
          CheckOutModel.fromJson(json.decode(response.body));
      return responseModel;
    } on TimeoutException {
      return Future.value(CheckOutModel.named(
          statusCode: 408,
          statusDescription: "Request TimeOut",
          orderNumber: ""));
    } on SocketException {
      return Future.value(CheckOutModel.named(
          statusCode: 400, statusDescription: "Bad Request", orderNumber: ""));
    } catch (e) {
      return Future.value(CheckOutModel.named(
          statusCode: 500, statusDescription: "Server Error", orderNumber: ""));
    }
  }

  Future<UserInfoModel> getProfileRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      UserInfoModel userInfoModel =
          UserInfoModel.fromJson(jsonDecode(response.body));
      return userInfoModel;
    } catch (e) {
      return Future.value(UserInfoModel(
          userId: '',
          firstname: '',
          lastname: '',
          email: '',
          profileImg: '',
          city: '',
          zip: '',
          phone: '',
          gender: '',
          sessionId: ''));
    }
  }

  Future<GetRestaurantModel> getRestaurantRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetRestaurantModel getRestaurant =
          GetRestaurantModel.fromJson(jsonDecode(response.body));
      return getRestaurant;
    } catch (e) {
      return Future.value(GetRestaurantModel(
          restaurantList: [], pagination: '', totalData: -1, categoryList: []));
    }
  }

  Future<GetRestaurantMenuModel> getRestaurantMenuRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetRestaurantMenuModel getRestaurant =
          GetRestaurantMenuModel.fromJson(jsonDecode(response.body));
      return getRestaurant;
    } catch (e) {
      return Future.value(GetRestaurantMenuModel.reqParameter(
          restId: '',
          restName: '',
          restEmail: '',
          restLat: '',
          restLong: '',
          restLogo: '',
          deliveryCost: '',
          minOrderAmount: '',
          overallRating: '',
          totalReviews: -1,
          testWebsite: '',
          restZip: '',
          restCity: '',
          restAddress: '',
          restOwner: '',
          restaurantCode: '',
          delivery: '',
          pickup: '',
          listOfCategoryModel: [],
          listOfMenuModel: [],
          listOfRestaurantReview: [],
          listOfRestTiming: []));
    }
  }

  Future<GetMenuOptionModel> getMenuOptionRequest({
    required String url,
    bool needHeaders = true,
  }) async {
    try {
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      print(url);
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetMenuOptionModel getMenuOption = GetMenuOptionModel.fromJson(
        jsonDecode(response.body),
      );
      return getMenuOption;
    } catch (e) {
      return Future.value(
        GetMenuOptionModel(
          banner: 'Empty Banner',
          title: 'Empty title',
          image: '',
          addons: [],
          options: OptionsModel.empty(),
          description: 'Empty Description',
          restaurant: 'Empty restaurant',
          price: 'No price provided',
          hPrice: 'What is HPrice?',
        ),
      );
    }
  }

  Future<GetLoadAddonsModel> getLoadAddons({
    required String url,
    bool needHeaders = true,
  }) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetLoadAddonsModel getMenuOption = GetLoadAddonsModel.fromJson(
        jsonDecode(response.body),
      );
      return getMenuOption;
    } catch (e) {
      print('Get Load Addones Failed');
      return Future.value(GetLoadAddonsModel(listOfAddons: []));
    }
  }

  Future<GetTimeModel> getTimeRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetTimeModel getTime = GetTimeModel.fromJson(jsonDecode(response.body));
      return getTime;
    } catch (e) {
      return Future.value(GetTimeModel(time: []));
    }
  }

  Future<ResponseModel> postMultipartRequest(
      {required String url,
      required List<OptionModel> listOfSingleAddons,
      required List<OptionModel> listOfMultiAddons,
      required String note,
      required String quantity,
      required String restaurantId,
      required String menuId,
      required String hiddenPrice,
      required String sessionId}) async {
    try {
      Map<String, String> customHeader = await _getHeaders();
      if (customHeader.isNotEmpty &&
          customHeader.entries.first.value.isNotEmpty) {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(url));

        request.headers.addAll(customHeader);
        request.fields['note'] = note;
        request.fields['quantity'] = quantity;
        request.fields['resturent'] = restaurantId;
        request.fields['hidden_price'] = hiddenPrice;
        request.fields['sessid'] = sessionId;
        request.fields['menu'] = menuId;

        if (listOfMultiAddons.isNotEmpty) {
          for (int i = 0; i < listOfMultiAddons.length; i++) {
            request.fields['multiaddons[]'] = listOfMultiAddons[i].id;
          }
        }
        if (listOfSingleAddons.isNotEmpty) {
          for (int i = 0; i < listOfSingleAddons.length; i++) {
            request.fields['addons[${listOfSingleAddons[i].addonId}]'] =
                listOfSingleAddons[i].id;
          }
        }
        http.StreamedResponse streamedResponse = await request.send();
        http.Response httpResponse =
            await http.Response.fromStream(streamedResponse);
        ResponseModel response =
            ResponseModel.fromJson(jsonDecode(httpResponse.body));
        return Future.value(response);
      } else {
        return Future.value(ResponseModel.named(
            statusCode: 404,
            statusDescription: "Client authentication failed",
            data: ""));
      }
    } on TimeoutException {
      return Future.value(ResponseModel.named(
          statusCode: 408,
          statusDescription: "Request TimeOut",
          data: "Request TimeOut"));
    } on SocketException {
      return Future.value(ResponseModel.named(
          statusCode: 400,
          statusDescription: "Bad Request",
          data: "Bad Request"));
    } catch (e) {
      return Future.value(ResponseModel.named(
          statusCode: 500,
          statusDescription: "Server Error",
          data: "Server Error"));
    }
  }

  Future<ResponseModel> postMultipartRequestForOption(
      {required String url,
      required List<OptionModel> listOfSingleAddons,
      required List<OptionModel> listOfMultiAddons,
      required String note,
      required String quantity,
      required String restaurantId,
      required String menuId,
      required String hiddenPrice,
      required String sessionId,
      required String optionId}) async {
    try {
      Map<String, String> customHeader = await _getHeaders();
      if (customHeader.isNotEmpty &&
          customHeader.entries.first.value.isNotEmpty) {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(url));

        request.headers.addAll(customHeader);
        request.fields['note'] = note;
        request.fields['quantity'] = quantity;
        request.fields['resturent'] = restaurantId;
        request.fields['hidden_price'] = hiddenPrice;
        request.fields['sessid'] = sessionId;
        request.fields['menu'] = menuId;
        request.fields['option'] = optionId;

        if (listOfMultiAddons.isNotEmpty) {
          for (int i = 0; i < listOfMultiAddons.length; i++) {
            request.fields['multiaddons[$i]'] = listOfMultiAddons[i].id;
          }
        }
        if (listOfSingleAddons.isNotEmpty) {
          for (int i = 0; i < listOfSingleAddons.length; i++) {
            request.fields['addons[${listOfSingleAddons[i].addonId}]'] =
                listOfSingleAddons[i].id;
          }
        }
        http.StreamedResponse streamedResponse = await request.send();
        http.Response httpResponse =
            await http.Response.fromStream(streamedResponse);
        ResponseModel response =
            ResponseModel.fromJson(jsonDecode(httpResponse.body));
        return Future.value(response);
      } else {
        return Future.value(ResponseModel.named(
            statusCode: 404,
            statusDescription: "Client authentication failed",
            data: ""));
      }
    } on TimeoutException {
      return Future.value(ResponseModel.named(
          statusCode: 408,
          statusDescription: "Request TimeOut",
          data: "Request TimeOut"));
    } on SocketException {
      return Future.value(ResponseModel.named(
          statusCode: 400,
          statusDescription: "Bad Request",
          data: "Bad Request"));
    } catch (e) {
      return Future.value(ResponseModel.named(
          statusCode: 500,
          statusDescription: "Server Error",
          data: "Server Error"));
    }
  }

  Future<GetCartModel> getCartRequest({
    required String url,
    bool needHeaders = true,
  }) async {
    try {
      print('Get Cart Request: $url');
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetCartModel getMenuOption =
          GetCartModel.fromJson(jsonDecode(response.body));
      return getMenuOption;
    } catch (e) {
      return Future.value(GetCartModel(
          items: [],
          totalPurchase: 0.0,
          deliveryFee: '',
          minimumOrder: '',
          cartTotalAmount: 0.0,
          cartTotalQty: 0,
          type: '',
          message: ''));
    }
  }

  Future<GetOrderModel> getOrderRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetOrderModel getOrders =
          GetOrderModel.fromJson(jsonDecode(response.body));
      return getOrders;
    } catch (e) {
      return Future.value(
          GetOrderModel(myOrders: [], showingTotalOrders: 0, totalOrders: 0));
    }
  }

  Future<GetOrderDetailModel> getOrderDetailRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetOrderDetailModel getOrderDetail =
          GetOrderDetailModel.fromJson(jsonDecode(response.body));
      return getOrderDetail;
    } catch (e) {
      return Future.value(GetOrderDetailModel(
          status2: '',
          status: '',
          name: '',
          shipping: '',
          street: '',
          house: '',
          floor: '',
          address: '',
          address2: '',
          zip: '',
          city: '',
          phone: '',
          code: '',
          needAt: '',
          createdAt: '',
          items: Items.empty(),
          subtotal: 0.0,
          orderNote: '',
          deliveryFee: '',
          orderGrandTotal: ''));
    }
  }

  Future<GetMyReviewModel> getMyReviewRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetMyReviewModel getMyReviews =
          GetMyReviewModel.fromJson(jsonDecode(response.body));
      return getMyReviews;
    } catch (e) {
      return Future.value(GetMyReviewModel(
          myReviews: [], showingTotalReviews: 0, totalReviews: 0));
    }
  }

  Future<GetReviewDataModel> getReviewDataRequest(
      {required String url, bool needHeaders = true}) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: (needHeaders) ? await _getHeaders() : {},
          )
          .timeout(const Duration(minutes: 5));
      GetReviewDataModel getReviewData =
          GetReviewDataModel.fromJson(jsonDecode(response.body));
      return getReviewData;
    } catch (e) {
      return Future.value(GetReviewDataModel(deliveryTime: [], showNames: []));
    }
  }

  Future<ResponseModel> getRequestWithOutHeader({required String url}) async {
    try {
      http.Response response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: _requestTimeOut));
      ResponseModel responseModel = ResponseModel();
      if (response.body.length > 4) {
        responseModel.statusCode = response.statusCode;
        responseModel.statusDescription = "Success";
        responseModel.data = response.body;
      }

      return responseModel;
    } on TimeoutException {
      return Future.value(ResponseModel.named(
          statusCode: 408, statusDescription: "Request TimeOut", data: ""));
    } on SocketException {
      return Future.value(ResponseModel.named(
          statusCode: 400, statusDescription: "Bad Request", data: ""));
    } catch (_) {
      return Future.value(ResponseModel.named(
          statusCode: 500, statusDescription: "Server Error", data: ""));
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    // UserLoginModel userLoginModel=await UserSession().getUserLoginModel();
    return {
      'Accept': 'application/json',
    };
  }
}
