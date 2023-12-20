class UserInfoModel {
  String userId='';
  String firstname='';
  String lastname='';
  String email='';
  String profileImg='';
  String city='';
  String zip='';
  String phone='';
  String gender='';
  String sessionId='';

  UserInfoModel.empty();

  UserInfoModel(
      {required this.userId,
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.profileImg,
        required this.city,
        required this.zip,
        required this.phone,
        required this.sessionId,
        required this.gender});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']??'';
    firstname = json['firstname']??'';
    lastname = json['lastname']??'';
    email = json['email']??'';
    profileImg = json['profile_img']??'';
    city = json['city']??'';
    zip = json['zip']??'';
    phone = json['phone']??'';
    gender = json['gender']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fname'] = firstname;
    data['lname'] = lastname;
    data['email'] = email;
    data['profile_img'] = profileImg;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['gender'] = gender;
    data['sessid'] = sessionId;
    data['saveProfile'] = '1';
    return data;
  }

  @override
  String toString() {
    return 'UserInfoModel{userId: $userId, firstname: $firstname, lastname: $lastname, email: $email, profileImg: $profileImg, city: $city, zip: $zip, phone: $phone, gender: $gender}';
  }
}