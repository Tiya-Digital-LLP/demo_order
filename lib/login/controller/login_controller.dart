import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:demoorder/generated/login_entity.dart';
import 'package:demoorder/routes/app_pages.dart';
import 'package:demoorder/utils/constants.dart';
import 'package:demoorder/utils/custom_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  RxString latestMessage = 'User Register Sucsessfully'.obs;
  RxBool hasPermission = false.obs;
  RxBool isDialogOpen = false.obs;
  ReceivePort port = ReceivePort();

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

      login(order.value.text, mobile.value.text, latestMessage.value).then((_) {
        isLoading(false);

        Get.offAllNamed(Routes.mainscreen);
      });
    }
  }

  Future<void> login(String orderID, String mobileNumber, String msg) async {
    if (orderID == '123' || mobileNumber == '0000000000') {
      if (kDebugMode) {
        print("Skipping login due to default values.");
      }
      debugPrint('Skipping login due to default values}');
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();

      if (kDebugMode) {
        print("Order ID: $orderID");
        print("Phone: $mobileNumber");
        print('message_login_update: $msg');
      }

      debugPrint('Order ID: $orderID');
      debugPrint('Phone: $mobileNumber');
      debugPrint('message_login_update: $msg');

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}${Constants.login}'),
        body: {'order_id': orderID, 'phone': mobileNumber, 'msg': msg},
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (kDebugMode) {
          print("Full parsed response: $responseData");
        }
        debugPrint("Full parsed response: $responseData");

        LoginEntity loginEntity = LoginEntity.fromJson(responseData);

        if (loginEntity.responseCode.toString() == "1") {
          if (kDebugMode) {
            print('Login successful!');
          }
          debugPrint('Login successful!');

          await prefs.setString('order_id', orderID);
          await prefs.setString('mobile_number', mobileNumber);
          await prefs.setBool('isLoggedIn', true);

          await prefs.reload();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Login error: $e");
      }
      debugPrint("Login error: $e");
    }
  }
}
