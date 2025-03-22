import 'dart:async';
import 'dart:ui';
import 'package:demoorder/login/controller/login_controller.dart';
import 'package:demoorder/routes/app_pages.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}

/// Ensures Background Service is Always Running
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

/// Background Service Logic
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    service.setForegroundNotificationInfo(
      title: "Order App Service",
      content: "Running in foreground...",
    );

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }

    final controller = Get.find<LoginController>();

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool isForeground = await service.isForegroundService();
      if (!isForeground) {
        timer.cancel();
        return;
      }

      if (kDebugMode) {
        print('Login Service Running on main.dart');
      }
      debugPrint('Login Service Running on main.dart');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String savedOrderID = prefs.getString('order_id') ?? '123';
      String savedMobileNumber =
          prefs.getString('mobile_number') ?? '0000000000';

      controller.login(
        controller.order.value.text.isEmpty
            ? savedOrderID
            : controller.order.value.text,
        controller.mobile.value.text.isEmpty
            ? savedMobileNumber
            : controller.mobile.value.text,
      );
    });
  }
  service.invoke('update');
}

@pragma('vm:entry-point')
bool onIosBackground(ServiceInstance service) {
  if (kDebugMode) {
    print("🔵 iOS background execution triggered.");
  }
  return true;
}

/// Main App
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.background,
        ),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      ),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
    );
  }
}
