import 'package:liefermars/model/get_my_review_model.dart';
import 'package:liefermars/model/get_review_data_model.dart';
import 'package:liefermars/model/option_model.dart';
import 'package:liefermars/web_services/web_url.dart';
import '../model/address_model.dart';
import '../model/checkout_model.dart';
import '../model/get_cart_model.dart';
import '../model/get_load_addons_model.dart';
import '../model/get_menu_option_model.dart';
import '../model/get_order_detail_model.dart';
import '../model/get_order_model.dart';
import '../model/get_restaurant_menu_model.dart';
import '../model/get_restaurants_model.dart';
import '../model/response_model.dart';
import '../model/time_model.dart';
import '../utils/app_constants.dart';
import 'http_client.dart';

class RestaurantService{

  static final RestaurantService _instance = RestaurantService._internal();
  RestaurantService._internal(){
    _httpClient = HTTPClient();
  }
  factory RestaurantService()=>_instance;

  late HTTPClient _httpClient;

  Future<GetRestaurantModel> getRestaurantData({required String city,required String zip,required String page,required String deviceUniqueId,required String type})async{
    GetRestaurantModel getRestaurantModel = await _httpClient.getRestaurantRequest(
        url: '$kGetRestaurantURL?city=$city&zip=$zip&page=$page&type=$type&sessid=$deviceUniqueId',needHeaders: false);
    return getRestaurantModel;

  }

  Future<GetRestaurantModel> getRestaurantDataFilter({required String city,required String zip,required String page,required String deviceUniqueId,required String type,required String openNow,required String minimumAmount,required String rating,required String freeDelivery})async{
    GetRestaurantModel getRestaurantModel = await _httpClient.getRestaurantRequest(
        url: '$kGetRestaurantURL?city=$city&zip=$zip&page=$page&openNow=$openNow&type=$type&minimumAmount=$minimumAmount&rating=$rating&freedelivery=$freeDelivery&sessid=$deviceUniqueId',needHeaders: false);

    return getRestaurantModel;

  }

  Future<GetRestaurantModel> getRestaurantDataByCategory({required String city,required String zip,required String page,required String deviceUniqueId,required String catId})async{
    GetRestaurantModel getRestaurantModel = await _httpClient.getRestaurantRequest(
        url: '$kGetRestaurantURL?city=$city&zip=$zip&page=$page&category=$catId&sessid=$deviceUniqueId',needHeaders: false);
    return getRestaurantModel;

  }

  Future<GetRestaurantMenuModel> getRestaurantMenuData({required String restaurantName,required String restaurantCode,required String deviceUniqueId})async{
    GetRestaurantMenuModel getRestaurantModel = await _httpClient.getRestaurantMenuRequest(
        url: '$kGetMenuURL?resturent_slug=$restaurantName&resturent_code=$restaurantCode&sessid=$deviceUniqueId',needHeaders: false);
    return getRestaurantModel;

  }

  Future<GetMenuOptionModel> getMenuOptionData({required String menuId})async{
    GetMenuOptionModel getMenuOptionModel = await _httpClient.getMenuOptionRequest(
        url: '$kMenuOptionURL?menu_id=$menuId',needHeaders: false);
    return getMenuOptionModel;

  }

  Future<GetLoadAddonsModel> getLoadedAddons({required String menuId,required String optionId})async{
    GetLoadAddonsModel getLoadAddons = await _httpClient.getLoadAddons(
        url: '$kLoadAddons?menu=$menuId&option=$optionId',needHeaders: false);
    return getLoadAddons;

  }

  Future<GetTimeModel> getTime({required String deviceToken})async{
    GetTimeModel times = await _httpClient.getTimeRequest(
        url: '$kGetTimeURL?action=getasaplistmobile&sessid=$deviceToken',needHeaders: false);
    return times;

  }

  //

  Future<String> addToCart({ required List<OptionModel> listOfSingleAddons, required List<OptionModel> listOfMultiAddons,required String note,required String quantity,required String restaurantId,required String menuId,required String hiddenPrice,required String sessionId})async{
    ResponseModel responseModel = await _httpClient.postMultipartRequest(url: kAddToCartURL, listOfSingleAddons: listOfSingleAddons, listOfMultiAddons: listOfMultiAddons, note: note, quantity: quantity, restaurantId: restaurantId, menuId: menuId, hiddenPrice: hiddenPrice, sessionId: sessionId);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return "Item add to cart successfully.";
    }
    return responseModel.errorDescription;

  }

  Future<String> singleAddToCart({required List<OptionModel> listOfSingleAddons, required List<OptionModel> listOfMultiAddons,required String note,required String quantity,required String restaurantId,required String menuId,required String hiddenPrice,required String sessionId,required String optionId})async{
    ResponseModel responseModel = await _httpClient.postMultipartRequestForOption(url: kAddToCartURL, listOfSingleAddons: listOfSingleAddons, listOfMultiAddons: listOfMultiAddons, note: note, quantity: quantity, restaurantId: restaurantId, menuId: menuId, hiddenPrice: hiddenPrice, sessionId: sessionId,optionId: optionId);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return "Item add to cart successfully.";
    }
    return responseModel.errorDescription;

  }


  Future<GetCartModel> getCartData({required String deviceTokenId,required String shipping})async{
    GetCartModel getCartModel = await _httpClient.getCartRequest(
        url: '$kGetCartURL?action=checkout&shipping=$shipping&sessid=$deviceTokenId',needHeaders: false);
    return getCartModel;

  }

  Future<String> updateCart({required String cartTempId,required String notes,required String deviceToken,required String quantity})async{
    Map<String,String> requestBody = {
      "cartTempID":cartTempId,
      "quantity":quantity,
      "sessid":deviceToken,
      "note":notes
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kUpdateCartURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return 'Cart Updated successfully.';
    }
    return responseModel.errorDescription;

  }

  Future<String> removeCart({required String cartTempId,required String deviceToken})async{
    Map<String,String> requestBody = {
      "code":cartTempId,
      "sessid":deviceToken,
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kDeleteCartItemURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return 'Item Deleted!';
    }
    return responseModel.statusDescription;

  }

  Future<CheckOutModel> checkOut({required AddressModel addressModel,required String deviceToken,required String notes,required String deliveryTime,required String shipping,required String paymentType})async{
    Map<String,String> requestBody = {
      'your_house_number': addressModel.street,
      'your_address': addressModel.yourAddress,
      'your_city': addressModel.yourCity,
      'your_zip': addressModel.youZip,
      'floor': addressModel.floor,
      'company': addressModel.company,
      'your_name': addressModel.clientName,
      'your_phone': addressModel.yourPhone,
      'your_email': addressModel.yourEmail,
      'note': notes,
      'shipping': shipping,
      'delivery_time': deliveryTime,
      'PaymentType': paymentType,
      'sessid': deviceToken
    };
    CheckOutModel responseModel = await _httpClient.postRequestForCheckOut(url: kCheckOutURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      responseModel.statusDescription=kPoorInternetConnection;
      return responseModel;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      responseModel.statusDescription=kNetworkError;
      return responseModel;
    }else if(responseModel.statusCode==1 && responseModel.orderNumber!=''){
      responseModel.statusDescription='success';
      return responseModel;
    }
    if(responseModel.errorDescription!=''){
      responseModel.statusDescription=responseModel.errorDescription;
    }

    return responseModel;

  }

  Future<CheckOutModel> checkOutStripe({required AddressModel addressModel,required String deviceToken,required String notes,required String deliveryTime,required String shipping,required String paymentType,required String requestId})async{
    Map<String,String> requestBody = {
      'your_house_number': addressModel.street,
      'your_address': addressModel.yourAddress,
      'your_city': addressModel.yourCity,
      'your_zip': addressModel.youZip,
      'floor': addressModel.floor,
      'company': addressModel.company,
      'your_name': addressModel.clientName,
      'your_phone': addressModel.yourPhone,
      'your_email': addressModel.yourEmail,
      'note': notes,
      'shipping': shipping,
      'delivery_time': deliveryTime,
      'PaymentType': paymentType,
      'sessid': deviceToken,
      'RequestID':requestId
    };
    CheckOutModel responseModel = await _httpClient.postRequestForCheckOut(url: kCheckOutURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      responseModel.statusDescription=kPoorInternetConnection;
      return responseModel;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      responseModel.statusDescription=kNetworkError;
      return responseModel;
    }else if(responseModel.statusCode==1 && responseModel.orderNumber!=''){
      responseModel.statusDescription='success';
      return responseModel;
    }
    return responseModel;

  }


  Future<GetOrderModel> getOrderData({required String deviceTokenId})async{
    GetOrderModel getOrderModel = await _httpClient.getOrderRequest(
        url: '$kGetOrdersURL?sessid=$deviceTokenId',needHeaders: false);
    return getOrderModel;

  }

  Future<GetOrderDetailModel> getOrderDetail({required String deviceTokenId,required String orderId})async{
    GetOrderDetailModel getOrderDetail = await _httpClient.getOrderDetailRequest(
        url: '$kGetOrderDetailURL?orderid=$orderId&sessid=$deviceTokenId',needHeaders: false);
    return getOrderDetail;

  }

  Future<String> submitRating({required String deviceToken,required String quanlity,required String comment,required String hashKey,required String deliveryQ, required String name,required String deliveryTime,required String orderId})async{
    Map<String,String> requestBody = {
      'order_id': orderId,
      'rating_data': quanlity,
      'drating_data': deliveryQ,
      'delivery_time': deliveryTime,
      'shownameas': name,
      'user_review': comment,
      'sessid': deviceToken,
      'review_key': hashKey
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kSubmitReviewURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return 'Your Review and Rating Successfully Submitted.';
    }
    return responseModel.errorDescription;

  }

  Future<GetMyReviewModel> getMyReview({required String deviceTokenId})async{
    GetMyReviewModel getMyReview = await _httpClient.getMyReviewRequest(
        url: '$kGetMyReviewURL?sessid=$deviceTokenId',needHeaders: false);
    return getMyReview;

  }

  Future<GetReviewDataModel> getReviewData({required String deviceTokenId})async{
    GetReviewDataModel getReviewData = await _httpClient.getReviewDataRequest(
        url: '$kGetReviewDataURL?action=getmysubmitratingmobile&sessid=$deviceTokenId',needHeaders: false);
    return getReviewData;

  }

  Future<String> becomeRestaurant({required String name,required String email,required String zip,required String city,required String phone,required String note})async{
    Map<String,String> requestBody = {
    'postal_code': zip,
    'user_note': note,
    'your_restaurant_name': name,
    'your_restaurant_phone': phone,
    'your_restaurant_email': email,
    'city': city,
    'saveProfile': '1'
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kBecomeRestaurant,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return 'Success';
    }
    return responseModel.errorDescription;

  }

  Future<String> recommendRestaurant({required String name,required String email,required String zip,required String city,required String note})async{
    Map<String,String> requestBody = {
      'postal_code': zip,
      'user_note': note,
      'your_restaurant_name': name,
      'your_restaurant_email': email,
      'city': city,
      'saveProfile': '1'
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kBecomeRestaurant,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return 'Success';
    }
    return responseModel.errorDescription;

  }


}