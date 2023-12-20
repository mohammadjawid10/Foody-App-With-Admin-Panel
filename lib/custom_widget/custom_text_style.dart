import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const FontWeight semiBold = FontWeight.w600;
const FontWeight medium = FontWeight.w500;
const FontWeight regular = FontWeight.w400;
const FontWeight bold = FontWeight.w700;


TextStyle heading1SemiBold(
    {Color? color,
      double? fontSize = 30,
      FontWeight? fontWeight = semiBold}) {
  return GoogleFonts.notoSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight
  );
}

TextStyle headingBold(
    {Color? color,
      double? fontSize = 18,
      FontWeight? fontWeight = bold}) {
   return GoogleFonts.notoSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight
  );
}
TextStyle heading1(
    {Color? color,
      double? fontSize = 30,
      FontStyle? fontStyle=FontStyle.normal,
      FontWeight? fontWeight = regular}) {
  return GoogleFonts.notoSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    fontStyle: fontStyle
  );
}

TextStyle bodyMediumMedium(
    {Color? color = Colors.black,
      double? fontSize = 20,
      FontWeight? fontWeight = medium}) {
  return GoogleFonts.notoSans(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight
  );
}