import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import '../model/response_model.dart';
import '../web_services/http_client.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CommonCode {
  static final CommonCode _instance = CommonCode._internal();
  CommonCode._internal();
  factory CommonCode() => _instance;

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Future<bool> checkInternetAccess() async {
    HTTPClient httpClient = HTTPClient();
    ResponseModel response = await httpClient.getRequestWithOutHeader(
        url: "https://www.google.com/");
    if (response.statusCode != 400 && response.statusCode != 408 &&
        response.statusCode != 500) {
      return await checkInternetConnection() && true;
    }
    return await checkInternetConnection() && false;
  }

  Future<File> compressImage(File file) async {

    CompressFormat compressFormat = CompressFormat.jpeg;
    try {
      final filePath = file.absolute.path;
      int lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      if (lastIndex == -1) {
        lastIndex = filePath.lastIndexOf(RegExp(r'.png'));
        compressFormat = CompressFormat.png;
      }
      final imageSplit = filePath.substring(0, (lastIndex));
      final outPath = "${imageSplit}_out${filePath.substring(lastIndex)}";
      File? compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          quality: 50, format: compressFormat);

      if(compressedImage!=null){
        return compressedImage;
      }
      else {
        return file;
      }
    } catch (e) {
      return file;
    }
  }



}