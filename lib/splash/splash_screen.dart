import 'dart:async';
import 'package:demoorder/login/controller/login_controller.dart';
import 'package:demoorder/routes/app_pages.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:demoorder/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final LoginController controller = Get.put(LoginController());
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation for "V"
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Slide animation for "Velvero"
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      _slideController.forward();
    });

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(Routes.login);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Center fade-in text
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text('V', style: textStyleW700(100, AppColors.blackText)),
            ),
          ),

          // Bottom slide-in text
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: Text(
                  'Velvero',
                  style: textStyleW700(size.width * 0.052, AppColors.blackText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
