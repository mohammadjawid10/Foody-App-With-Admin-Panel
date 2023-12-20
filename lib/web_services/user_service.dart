
import 'package:liefermars/model/user_signup_model.dart';
import 'package:liefermars/web_services/web_url.dart';
import '../model/response_model.dart';
import '../model/user_info_model.dart';
import '../utils/app_constants.dart';
import 'http_client.dart';

class UserService{

  static final UserService _instance = UserService._internal();
  UserService._internal(){
    _httpClient = HTTPClient();
  }
  factory UserService()=>_instance;

  late HTTPClient _httpClient;

  Future<String> loginUser({required String password,required String email,required String deviceToken})async{
    Map<String,String> requestBody = {
      "email":email,
      "password":password,
      "sessid":deviceToken,
      "remember_me":"1"
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kLoginUserURL,
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

  Future<String> signUpUser(UserSignUpModel userSignupModel)async{
    Map<String,dynamic> requestBody = userSignupModel.toJson();
    ResponseModel responseModel = await _httpClient.postRequest(url: kSignUpUserURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return responseModel.statusDescription;
    } else if(responseModel.statusCode==0&&responseModel.statusDescription!=''){
      return responseModel.statusDescription;
    }
    return responseModel.errorDescription;

  }

  Future<String> socialLoginUser({required String name,required String email,required String deviceToken,required String providerId,required String photoUrl,required String providerName})async{
    Map<String,String> requestBody = {
    'loginwithsocial': 'loginwithsocial',
      'sessid': deviceToken,
      'email': email,
    'first_name': name,
    'last_name': '',
    'provider_id': providerId,
    'photourl': photoUrl,
    'provider_name': providerName
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kSocialLogin,
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


  Future<String> forgetPasswordUser({required String email})async{
    Map<String,String> requestBody = {
      "email":email,
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kForgetPasswordURL,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return responseModel.statusDescription;
    }
    return responseModel.statusDescription;

  }

  Future<UserInfoModel> getUserData({required String deviceToken})async{
    UserInfoModel userInfoModel = await _httpClient.getProfileRequest(
        url: '$kGetUerInfoURL?getprofiledata=1&sessid=$deviceToken',needHeaders: false);
    return userInfoModel;

  }

  Future<String> upDateProfile({required UserInfoModel userInfoModel})async{
    ResponseModel responseModel = await _httpClient.postMultipartProfileUpdateRequest(url: kUpdateProfileURL,
        userInfoModel: userInfoModel);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return responseModel.statusDescription;
    }
    return responseModel.errorDescription;

  }

  Future<String> userLogOut({required String sessionId}) async {
    ResponseModel responseModel = await _httpClient.postRequest(
        url: '$kLogOutUrl?sessid=$sessionId');
    if (responseModel.statusCode==1 &&
        responseModel.statusDescription == "you are logout successfully.") {
      return responseModel.statusDescription;

    } else {
      return responseModel.statusDescription;
    }

  }

  Future<String> deleteUser({required String password,required String deviceToken})async{
    Map<String,String> requestBody = {
      'password': password,
      'sessid': deviceToken,
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kDeleteAccountUrl,
        requestBody: requestBody,needHeaders: false);
    if(responseModel.statusCode == 408){
      return kPoorInternetConnection;
    }else if(responseModel.statusCode == 400 || responseModel.statusCode == 500){
      return kNetworkError;
    }else if(responseModel.statusCode==1){
      return 'Success';
    }
    return responseModel.statusDescription;

  }


  Future<String> changeUserPassword({required String password,required String confirmPassword,required String deviceToken,required String oldPassword})async{
    Map<String,String> requestBody = {
    'sessid': deviceToken,
    'old_password': oldPassword,
    'new_password': password,
    'confirm_password': confirmPassword,
    'changePassword': '1'
    };
    ResponseModel responseModel = await _httpClient.postRequest(url: kChangePasswordURL,
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