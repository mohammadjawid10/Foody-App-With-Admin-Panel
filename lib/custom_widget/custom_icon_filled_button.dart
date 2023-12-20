import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liefermars/custom_widget/custom_text_style.dart';
import 'package:liefermars/custom_widget/image_widget.dart';
import 'package:liefermars/utils/app_colors.dart';


class CustomIconFilledButton extends GetView {
  final Function() onPress;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final String iconData;
  final double height;

  const CustomIconFilledButton(
      {super.key,
        required this.onPress,
        required this.text,
        this.textColor = Colors.white,
        this.height=53,
        this.iconData='',
        this.iconColor=Colors.white,
        this.backgroundColor = const Color(0xFFE89CAE)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.4),
          side: BorderSide(color: AppColors.blackColor),
        ),
        elevation: 6,
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, height),
      ),
      child: Row(
        children: [
          Text(text,
              style: heading1(fontWeight:FontWeight.w200,color: textColor,fontSize: 16)),
          const SizedBox(width: 15),
          iconData!=''?
          iconWidget(img: iconData,size: 16,color: iconColor):const SizedBox(),
        ],
      ),
    );
  }
}