import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:demoorder/generated/login_entity.dart';
import 'package:demoorder/utils/constants.dart';
import 'package:demoorder/utils/custom_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
class LoginController extends GetxController {
  FocusNode? currentFocus = FocusManager.instance.primaryFocus;
  Rx<TextEditingController> order = TextEditingController().obs;
  Rx<TextEditingController> mobile = TextEditingController().obs;

  RxBool orderError = false.obs;
  RxBool mobileError = false.obs;

  RxBool isOrderTyping = false.obs;
  RxBool isMobileTyping = false.obs;

  var isLoading = false.obs;

  Timer? _timer;

  RxString latestMessage = ''.obs;
  RxBool hasPermission = false.obs;
  ReceivePort port = ReceivePort();

  @override
  void onInit() {
    super.onInit();
    startAutoRefresh();
    checkPermissionsAndStart();
  }

  ///  Callback function for receiving notifications
  @pragma('vm:entry-point')
  static void _callback(NotificationEvent evt) {
    if (kDebugMode) {
      print("Received notification event: $evt");
    }
    final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
    if (send != null && evt.text != null && evt.text!.isNotEmpty) {
      send.send(evt.text);
    } else {
      if (kDebugMode) {
        print("Notification received but NOT sent to isolate!");
      }
    }
  }

  ///  Permission Handling
  Future<void> checkPermissionsAndStart() async {
    var permissionGranted = await NotificationsListener.hasPermission ?? false;

    if (!permissionGranted) {
      if (kDebugMode) {
        print("Notification access NOT granted, opening settings...");
      }
      await NotificationsListener.openPermissionSettings();
      permissionGranted = await NotificationsListener.hasPermission ?? false;
    }

    hasPermission.value = permissionGranted;

    if (permissionGranted) {
      startNotificationListener();
    } else {
      if (kDebugMode) {
        print("Permission not granted. Trying again in 5 seconds...");
      }
      Future.delayed(Duration(seconds: 5), checkPermissionsAndStart);
    }
  }

  ///  Starts Notification Listener in Foreground & Background
  Future<void> startNotificationListener() async {
    NotificationsListener.initialize(callbackHandle: _callback);

    IsolateNameServer.removePortNameMapping("_listener_");
    if (!IsolateNameServer.registerPortWithName(port.sendPort, "_listener_")) {
      if (kDebugMode) {
        print("Failed to register isolate. Retrying...");
      }
      Future.delayed(Duration(seconds: 2), startNotificationListener);
    }

    port.listen((message) {
      if (message is String && message.isNotEmpty) {
        if (latestMessage.value != message) {
          latestMessage.value = message;
          update();
        }
        if (kDebugMode) {
          print("Updated Notification Message: $latestMessage");
        }
      }
    });

    var isRunning = (await NotificationsListener.isRunning) ?? false;
    if (!isRunning) {
      await NotificationsListener.startService(
        foreground: true,
        title: "Listener Running",
        description: "Notification Listener Active",
      );
    }
  }

  void startAutoRefresh() async {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (!_timer!.isActive) return;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();

      String savedOrderID = prefs.getString('order_id') ?? '123';
      String savedMobileNumber =
          prefs.getString('mobile_number') ?? '0000000000';

      if (kDebugMode) {
        print("Fetched Order ID (Before Login Call): $savedOrderID");
        print("Fetched Mobile Number (Before Login Call): $savedMobileNumber");
      }

      login(
        order.value.text.isNotEmpty ? order.value.text : savedOrderID,
        mobile.value.text.isNotEmpty ? mobile.value.text : savedMobileNumber,
      );
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    port.close();
    super.onClose();
  }

  void orderValidation() {
    if (order.value.text.isEmpty) {
      orderError.value = true;
    } else {
      orderError.value = false;
    }

    if (orderError.value) {
      isOrderTyping.value = true;
    }
  }

  void mobileValidation() {
    if (mobile.value.text.isEmpty) {
      mobileError.value = true;
    } else {
      mobileError.value = false;
    }

    if (mobileError.value) {
      isMobileTyping.value = true;
    }
  }

  void loginValidation(BuildContext context) {
    FocusScope.of(context).unfocus();
    isOrderTyping.value = true;
    isMobileTyping.value = true;

    orderValidation();
    mobileValidation();

    if (order.value.text.isEmpty) {
      showToasterrorborder("Please Enter OrderID", context);
    } else if (mobile.value.text.isEmpty) {
      showToasterrorborder("Please Enter Mobile Number", context);
    } else {
      _timer?.cancel();
      isLoading(true);
      login(order.value.text, mobile.value.text).then((_) {
        isLoading(false);
        startAutoRefresh();
      });
    }
  }

  Future<void> login(String orderID, String mobileNumber) async {
    if (orderID == '123' || mobileNumber == '0000000000') {
      if (kDebugMode) {
        print("Skipping login due to default values.");
      }
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String messageValue =
          latestMessage.value.isNotEmpty
              ? latestMessage.value
              : 'User Registered Successfully';

      if (kDebugMode) {
        print("Order ID: $orderID");
        print("Phone: $mobileNumber");
        print('message_login_update: $messageValue');
      }

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.login}'),
        body: {'order_id': orderID, 'phone': mobileNumber, 'msg': messageValue},
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (kDebugMode) {
          print("Full parsed response: $responseData");
        }

        LoginEntity loginEntity = LoginEntity.fromJson(responseData);

        if (loginEntity.responseCode.toString() == "1") {
          if (kDebugMode) {
            print('Login successful!');
          }

          await prefs.setString('order_id', orderID);
          await prefs.setString('mobile_number', mobileNumber);
          await prefs.setBool('isLoggedIn', true);
          await prefs.reload();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Login failed: $e");
      }
    }
  }
}
