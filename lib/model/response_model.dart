
class ResponseModel {
  int statusCode= -1;
  String statusDescription = "";
  String errorDescription='';
  dynamic data;

  ResponseModel();
  ResponseModel.named({required this.statusCode, required this.statusDescription, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode =(json["type"] != null && json["type"]=='success')?1:0;
    statusDescription =  json["msg"]??"";
    errorDescription=json["errorarr"]??"";
   /* if(statusDescription == "The given data was invalid."){
      Map<String,dynamic> error = json["errors"];
      error.forEach((key, value) {
        if(value != null && value.length > 0){
          data = value[0];
        }else{
          data = value;
        }
      });
    }else{
      data = json["data"];
    }*/
  }

  Map<String, dynamic> toJson() {
    return {
      'success': statusCode,
      'message': statusDescription,
      'errorMessage':errorDescription,
    };
  }

  @override
  String toString() {
    return 'ResponseModel{statusCode: $statusCode, statusDescription: $statusDescription, data: $data}';
  }
}
