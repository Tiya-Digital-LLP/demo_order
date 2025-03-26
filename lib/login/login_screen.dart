import 'dart:io';

import 'package:demoorder/generated/assets.dart';
import 'package:demoorder/login/controller/login_controller.dart';
import 'package:demoorder/utils/app_colors.dart';
import 'package:demoorder/utils/extension_classes.dart';
import 'package:demoorder/widget/border_text_field.dart';
import 'package:demoorder/widget/custom_app_bar.dart';
import 'package:demoorder/widget/custom_mobile_field.dart';
import 'package:demoorder/widget/normal_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final LoginController controller = Get.put(LoginController());
  RxBool hasPermission = false.obs;
  RxBool isDialogOpen = false.obs;
  bool started = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observe app lifecycle
    checkPermissionsAndStart();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      bool permissionGranted =
          await NotificationsListener.hasPermission ?? false;
      if (permissionGranted) {
        hasPermission.value = true;
        startListening();
        if (isDialogOpen.value) {
          Get.back(); // Close dialog when returning with granted permission
          isDialogOpen.value = false;
        }
      } else if (!isDialogOpen.value) {
        showPermissionDialog(); // Reopen dialog if permission not granted
      }
    }
  }

  /// Permission Handling
  Future<void> checkPermissionsAndStart() async {
    var permissionGranted = await NotificationsListener.hasPermission ?? false;
    if (!permissionGranted) {
      showPermissionDialog();
    } else {
      hasPermission.value = true;
      startListening();
    }
  }

  /// Show Permission Dialog
  void showPermissionDialog() {
    isDialogOpen.value = true;
    Get.bottomSheet(
      // ignore: deprecated_member_use
      WillPopScope(
        onWillPop: () async => false, // Prevent back button closing
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Notification Access Required",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "This app requires access to notifications to function properly. Please grant permission.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await NotificationsListener.openPermissionSettings();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text("Allow"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else {
                        exit(0);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isDismissible: false, // Prevents closing by tapping outside
      enableDrag: false, // Prevents dragging to close
    );
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          size: MediaQuery.of(context).size,
          titleText: 'Track Your Order',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(Assets.svgLogin),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: AppColors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Obx(
                          () => BorderTextField(
                            keyboard: TextInputType.name,
                            textInputType: const [],
                            hint: "Order ID",
                            controller: controller.order.value,
                            isError: controller.orderError.value,
                            byDefault: !controller.isOrderTyping.value,
                            maxLength: 100,
                            onChanged: (value) {
                              controller.orderValidation();
                              controller.isOrderTyping.value = true;
                            },
                            height: 58,
                          ),
                        ),
                        15.sbh,
                        Obx(
                          () => CustomMobileField(
                            height: 58,
                            hint: "Mobile Number",
                            controller: controller.mobile.value,
                            textInputType: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboard: TextInputType.phone,
                            isError: controller.mobileError.value,
                            byDefault: !controller.isMobileTyping.value,
                            onChanged: (value) {
                              controller.mobileValidation();
                              controller.isMobileTyping.value = true;
                            },
                          ),
                        ),
                        20.sbh,
                        NormalButton(
                          height: 50,
                          onPressed: () {
                            controller.loginValidation(context);
                          },
                          text: 'Track Order',
                          isLoading: controller.isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
            ],
          ),
        ),
      ),
    );
  }
}
