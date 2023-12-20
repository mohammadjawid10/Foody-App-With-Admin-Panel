import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import 'custom_text_style.dart';

class CustomTextField extends StatelessWidget{
  String hintText = "";
  bool enabled = true;
  bool isAllProduct = false;
  bool isPassword = false;
  bool showPassword = false;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputFormatter? textInputFormatter;
  Color color = Colors.white;
  int? maxLength;
  TextInputType? keyBoardType;
  double? fontSize;
  dynamic onChanged;
  bool readOnly = false;
  Color? fillColor;
  double radius = 30;
  TextEditingController? controller;
  bool isMultiLine = false;
  FocusNode? focusNode;
  double height = 52;
  double width = Get.width;
  double paddingHorizontal;
  bool autoCorrect=false;
  TextInputAction? textInputAction;
  List<String> autofillHints=<String>[];

  CustomTextField({super.key, this.hintText = "",
    this.enabled = true,
    this.isAllProduct = false,
    this.isPassword = false,
    this.showPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.color = Colors.white,
    this.maxLength,
    this.keyBoardType,
    this.fontSize,
    this.onChanged,
    this.readOnly = false,
    this.fillColor,
    this.radius = 8,
    this.controller,
    this.isMultiLine = false,
    this.focusNode,
    this.height = 52,
    this.width = double.infinity,
    this.textInputAction,
    this.paddingHorizontal = 0,
    this.textInputFormatter,
    this.autofillHints=const [],
    this.autoCorrect=false
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMultiLine ? null : height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor,
              offset: const Offset(0.0, 5.0),
              blurRadius: 3.0,
              spreadRadius: 2
            ),
          ]
      ),
      child: TextField(
        readOnly: readOnly,
        focusNode: focusNode,
        enabled: enabled,
        controller: controller,
        obscureText: showPassword,
        textAlign: maxLength != null ? TextAlign.center : TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        maxLength: maxLength,
        keyboardType: keyBoardType,
        style: maxLength != null
            ? heading1SemiBold()
            : bodyMediumMedium(color: AppColors.blackColor,fontSize: fontSize),
        obscuringCharacter: '*',
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 2,right: 2),
          border: border(radius: radius),
         enabledBorder: border(radius: radius),
          focusedBorder:border(radius: radius),
          filled: true,
          counterText: "",
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.blackColor,
          hintStyle: bodyMediumMedium(color: AppColors.textColor,fontSize: fontSize),
          hintText: hintText,
          fillColor: fillColor??AppColors.textFieldBackgroundColor,
        ),
        onChanged: (text) {
          if(onChanged!=null) {
            onChanged(text);
          }
        },
      ),
    );
  }


  InputBorder border({required double radius, bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      borderSide: BorderSide(
        color: AppColors.blackColor,
        width: 1
      )
    );
  }
}