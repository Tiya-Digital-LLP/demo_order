import 'dart:isolate';
import 'dart:ui';

import 'package:demoorder/login/controller/login_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:get/get.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final List<NotificationEvent> _log = [];
  bool started = false;
  ReceivePort port = ReceivePort();
  final LoginController controller = Get.put(LoginController());

  void initialize() {
    startListening();
    initPlatformState();
  }

  @pragma('vm:entry-point')
  static void _callback(NotificationEvent evt) {
    if (kDebugMode) {
      print("send evt to ui: $evt");
    }
    final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
    if (send == null) {
      if (kDebugMode) {
        print("can't find the sender");
      }
    }
    send?.send(evt);
  }

  Future<void> initPlatformState() async {
    NotificationsListener.initialize(callbackHandle: _callback);

    IsolateNameServer.removePortNameMapping("_listener_");
    IsolateNameServer.registerPortWithName(port.sendPort, "_listener_");
    port.listen((message) => onData(message));

    var isRunning = (await NotificationsListener.isRunning) ?? false;
    if (kDebugMode) {
      print("Service is ${!isRunning ? "not " : ""}already running");
    }

    started = isRunning;
  }

  void onData(NotificationEvent event) {
    _log.add(event);
    if (kDebugMode) {
      print("add event to log: $event");
    }

    refreshLoginAPI(event);
  }

  void refreshLoginAPI(NotificationEvent event) {
    controller.login(
      controller.order.value.text,
      controller.mobile.value.text,
      event.title ?? '',
    );
  }

  void startListening() async {
    if (kDebugMode) {
      print("start listening");
    }

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

    started = true;
  }
}
