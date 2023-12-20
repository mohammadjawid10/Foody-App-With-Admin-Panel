import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';


class CustomFilledButton extends GetView {
  final Function() onPress;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double fontSize;
  final double width;
  final double radius;

  const CustomFilledButton(
      {super.key,
        required this.onPress,
        required this.text,
        this.textColor = Colors.white,
        this.height=53,
        this.width=double.infinity,
        this.radius=15.4,
        this.fontSize=20,
        this.backgroundColor = const Color(0xFFE89CAE)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 6,
        backgroundColor: backgroundColor,
        minimumSize: Size(width, height),
      ),
      child: Text(text,
          style: headingBold(color: textColor,fontSize: fontSize)),
    );
  }
}