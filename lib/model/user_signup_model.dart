class UserSignUpModel{
  String userEmail ="";
  String userPassword = "";
  String userConfirmPassword = "";
  String sessionId = "";
  String userName="";


  UserSignUpModel.empty();

  UserSignUpModel(
      {
        required this.userEmail,
        required this.userPassword,
        required this.userConfirmPassword,
        required this.sessionId,
        required this.userName
      });



  Map<String,dynamic> toJson(){

    Map<String, dynamic> userModel = {};

    userModel["email"]=userEmail;
    userModel["password"]=userPassword;
    userModel["repeat_password"]=userConfirmPassword;
    userModel["your_name"]=userName;
    userModel["sessid"]=sessionId;
    return userModel;
  }

  @override
  String toString() {
    return 'UserRegisterModel{userEmail: $userEmail, userPassword: $userPassword, userConfirmPassword: $userConfirmPassword, sessionId: $sessionId, userName: $userName}';
  }
}