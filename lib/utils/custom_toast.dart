import 'package:demoorder/generated/assets.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:demoorder/utils/text_style.dart';
import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';

// verified with border
void showToastverifedborder(String message, BuildContext context) {
  final Size size = MediaQuery.of(context).size;

  toastification.show(
    context: context,
    alignment: Alignment.bottomCenter,
    backgroundColor: AppColors.white,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    showProgressBar: false,
    autoCloseDuration: const Duration(seconds: 5),
    icon: Image.asset(Assets.imagesChecked, height: 30),
    closeOnClick: true,
    primaryColor: Colors.green,
    title: Text(
      message,
      style: textStyleW700(
        size.width * 0.034,
        AppColors.blackText,
        isMetropolis: true,
      ),
    ),
  );
}

// error with border
void showToasterrorborder(String message, BuildContext context) {
  final Size size = MediaQuery.of(context).size;

  toastification.show(
    context: context,
    alignment: Alignment.bottomCenter,
    backgroundColor: AppColors.white,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    showProgressBar: false,
    autoCloseDuration: const Duration(seconds: 5),
    icon: Image.asset(Assets.imagesCancel, height: 35),
    primaryColor: Colors.red,
    title: Text(
      message,
      style: textStyleW700(
        size.width * 0.034,
        AppColors.blackText,
        isMetropolis: true,
      ),
    ),
  );
}
