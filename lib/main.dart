import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:demoorder/login/controller/login_controller.dart';
import 'package:demoorder/routes/app_pages.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:get/get.dart';

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

  final List<NotificationEvent> log = [];
  ReceivePort port = ReceivePort();
  final LoginController controller = Get.put(LoginController());

  // Static method to handle notifications in the background
  @pragma('vm:entry-point')
  void callback(NotificationEvent evt) {
    if (kDebugMode) {
      print("Send event to UI: $evt");
    }
    final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
    send?.send(evt);
  }

  // Handle notification events
  void onData(NotificationEvent event) {
    log.add(event);

    if (kDebugMode) {
      print("Added event to log: $event");
      print(event.toString());
    }

    // Refresh login API when message is received
    controller.login(
      controller.order.value.text,
      controller.mobile.value.text,
      event.title ?? '',
    );
  }

  // Initialize the notification listener
  Future<void> initPlatformState() async {
    NotificationsListener.initialize(callbackHandle: callback);

    IsolateNameServer.removePortNameMapping("_listener_");
    IsolateNameServer.registerPortWithName(port.sendPort, "_listener_");
    port.listen((message) => onData(message));

    var isRunning = (await NotificationsListener.isRunning) ?? false;
    if (kDebugMode) {
      print("Service is ${!isRunning ? "not " : ""}already running");
    }
  }

  await initPlatformState();
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    service.setForegroundNotificationInfo(
      title: "Order App Service",
      content: "Running in foreground...",
    );

    service.on('stopService').listen((event) {
      service.stopSelf();
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

@pragma('vm:entry-point')
class _MyAppState extends State<MyApp> {
  bool started = false;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  void startListening() async {
    if (kDebugMode) {
      print("start listening");
    }
    setState(() {});
    var hasPermission = (await NotificationsListener.hasPermission) ?? false;
    if (!hasPermission) {
      if (kDebugMode) {
        print("no permission, so open settings");
      }
      NotificationsListener.openPermissionSettings();
      return;
    }

    var isRunning = (await NotificationsListener.isRunning) ?? false;

    if (!isRunning) {
      await NotificationsListener.startService(
        foreground: false,
        title: "Listener Running",
        description: "Welcome to having me",
      );
    }

    setState(() {
      started = true;
    });
  }

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
