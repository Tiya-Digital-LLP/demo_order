import 'package:demoorder/login/login_screen.dart';
import 'package:demoorder/mainscreen/main_screen.dart';
import 'package:demoorder/splash/splash_screen.dart';
import 'package:demoorder/testscreen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.mainscreen, page: () => const MainScreen()),
    GetPage(name: Routes.test, page: () => Testscreen()),
  ];
}
