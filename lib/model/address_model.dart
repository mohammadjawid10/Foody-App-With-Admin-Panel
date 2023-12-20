class AddressModel{
  String street = "";
  String yourAddress = "";
  String yourCity = "";
  String youZip = "";
  String floor = "";
  String company = "";
  String clientName = "";
  String yourPhone = "";
  String yourEmail = "";

  AddressModel.empty();


  AddressModel.forDelivery(
      {required this.street,
        required this.yourAddress,
        required this.yourCity,
        required this.youZip,
        required this.floor,
        required this.company,
        required this.clientName,
        required this.yourPhone,
        required this.yourEmail});

  AddressModel.forPickUp(
      {
        required this.clientName,
        required this.yourPhone,
        required this.yourEmail});

  AddressModel.fromSessionData(Map<String, dynamic> json){
    street = json['your_house_number'] ?? "";
    yourAddress = json['your_address'] ?? "";
    yourCity = json['your_city'] ?? "";
    youZip = json['your_zip'] ?? "";
    floor = json['floor'] ?? "";
    company = json['company'] ?? "";
    yourEmail = json['your_email'] ?? "";
    yourPhone = json['your_phone'] ?? "";
    clientName = json['your_name'] ?? "";
  }

  Map<String, dynamic> toJsonForSession() {
    Map<String, dynamic> json = {
      'your_house_number': street,
      'your_address': yourAddress,
      'your_city': yourCity,
      'your_zip': youZip,
      'floor': floor,
      'company': company,
      'your_name': clientName,
      'your_phone': yourPhone,
      'your_email': yourEmail,

    };
    return json;
  }

  AddressModel.fromSessionDataPickup(Map<String, dynamic> json){
    yourEmail = json['your_email'] ?? "";
    yourPhone = json['your_phone'] ?? "";
    clientName = json['your_name'] ?? "";
  }

  Map<String, dynamic> toJsonForSessionPickup() {
    Map<String, dynamic> json = {
      'your_name': clientName,
      'your_phone': yourPhone,
      'your_email': yourEmail,

    };
    return json;
  }

  @override
  String toString() {
    return 'UserLoginModel{street: $street, yourAddress: $yourAddress, yourCity: $yourCity, youZip: $youZip, floor: $floor, company: $company, clientName: $clientName, yourPhone: $yourPhone, yourEmail: $yourEmail}';
  }
}