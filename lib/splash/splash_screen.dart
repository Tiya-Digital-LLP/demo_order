import 'dart:async';
import 'package:demoorder/generated/assets.dart';
import 'package:demoorder/login/controller/login_controller.dart';
import 'package:demoorder/routes/app_pages.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:demoorder/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.mainscreen); // Navigate to Main Screen
    } else {
      Get.offAllNamed(Routes.login); // Navigate to Login Screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 200, child: Image.asset(Assets.imagesLogo)),
            Text(
              'OrderApp',
              style: textStyleW700(size.width * 0.042, AppColors.blackText),
            ),
          ],
        ),
      ),
    );
  }
}
