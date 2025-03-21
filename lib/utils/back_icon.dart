import 'package:demoorder/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.bottomIcon,
          size: 18,
        ),
      ),
    );
  }
}
