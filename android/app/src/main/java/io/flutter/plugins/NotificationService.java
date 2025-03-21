package com.example.orderapp;

import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import android.util.Log;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.android.FlutterActivity;

public class NotificationService extends NotificationListenerService {

    private static final String CHANNEL = "notification_listener";
    private static MethodChannel methodChannel;

    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        String packageName = sbn.getPackageName();
        String notificationText = sbn.getNotification().extras.getString("android.text");

        if (packageName.equals("com.google.android.apps.messaging") && notificationText != null) { 
            Log.d("NotificationService", "SMS Received: " + notificationText);

            // Send SMS content to Flutter via MethodChannel
            if (methodChannel != null) {
                methodChannel.invokeMethod("logSMS", notificationText);
            }
        }
    }

    @Override
    public void onNotificationRemoved(StatusBarNotification sbn) {
        Log.d("NotificationService", "Notification Removed: " + sbn.getPackageName());
    }

    public static void setFlutterEngine(FlutterEngine flutterEngine) {
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
    }
}
