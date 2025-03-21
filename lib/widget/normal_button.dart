import 'package:demoorder/generated/assets.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:demoorder/utils/extension_classes.dart';
import 'package:demoorder/utils/text_style.dart';
import 'package:demoorder/widget/loader/custom_three_dot_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NormalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final Icon? icon;
  final double borderRadius;
  final List<Color>? gradientColors;
  final RxBool isLoading;

  const NormalButton({
    required this.onPressed,
    required this.text,
    required this.isLoading,
    this.fontSize = 14,
    this.height = 60,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 12,
    this.gradientColors,
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Obx(() {
        return ElevatedButton(
          onPressed: isLoading.value ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Container(
              width: double.infinity,
              height: height,
              alignment: Alignment.center,
              child:
                  isLoading.value
                      ? CustomThreeDotAnimation(
                        child: Lottie.asset(Assets.lottieDotLottie),
                      )
                      : icon == null
                      ? Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          color: Colors.white,
                          fontFamily: metropolisFontFamily,
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon!,
                          8.sbw,
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              fontFamily: metropolisFontFamily,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        );
      }),
    );
  }
}
