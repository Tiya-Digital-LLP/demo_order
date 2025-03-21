import 'package:demoorder/utils/app_colors.dart';
import 'package:flutter/material.dart';

String satoshiFontFamily = "Satoshi";
String metropolisFontFamily = "Metropolis";

TextStyle textStyleW700(double size, Color color, {bool isMetropolis = false}) {
  return TextStyle(
    fontFamily: isMetropolis ? metropolisFontFamily : satoshiFontFamily,
    fontWeight: FontWeight.bold,
    fontSize: size,
    color: color,
  );
}

TextStyle textStyleW600(double size, Color color, {bool isMetropolis = false}) {
  return TextStyle(
    fontFamily: isMetropolis ? metropolisFontFamily : satoshiFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: size,
    color: color,
  );
}

TextStyle textStyleW500(double size, Color color, {bool isMetropolis = false}) {
  return TextStyle(
    fontFamily: isMetropolis ? metropolisFontFamily : satoshiFontFamily,
    fontWeight: FontWeight.w500,
    fontSize: size,
    color: color,
  );
}

TextStyle textStyleW400(double size, Color color, {bool isMetropolis = false}) {
  return TextStyle(
    fontFamily: isMetropolis ? metropolisFontFamily : satoshiFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: size,
    color: color,
  );
}

BoxShadow customBoxShadow() {
  return BoxShadow(
    // ignore: deprecated_member_use
    color: AppColors.primaryColor.withOpacity(0.10),
    blurRadius: 13,
    offset: const Offset(0, 0),
    spreadRadius: 0,
  );
}
