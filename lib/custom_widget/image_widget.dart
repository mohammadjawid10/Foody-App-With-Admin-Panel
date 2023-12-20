import 'package:flutter/material.dart';


Widget imageIcon({required String img, Color? color, double? size = 24}) {
  if (color == null) {
    return Image.asset(
      Img.get(img),
      width: size,
      height: size,
    );
  }

  return ImageIcon(
    AssetImage(Img.get(img)),
    size: size,
    color: color,
  );
}


class Img {
  static String get(String? name){
    return 'assets/images/$name';
  }
}

Widget iconWidget({required String img, Color? color, double? size = 24}) {
  if (color == null) {
    return Image.asset(
      CustomIcon.get(img),
      width: size,
      height: size,
    );
  }

  return ImageIcon(
    AssetImage(CustomIcon.get(img)),
    size: size,
    color: color,
  );
}

class CustomIcon {
  static String get(String? name){
    return 'assets/icons/$name';
  }
}