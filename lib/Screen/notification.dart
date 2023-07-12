import 'dart:developer';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:password/main.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  void showNotification() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "notifications", "Notification Sound",
            sound: RawResourceAndroidNotificationSound("notify"),
            playSound: true,
            priority: Priority.max,
            importance: Importance.max);

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      sound: 'notify',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    // DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    await flutterLocalNotificationsPlugin.show(
        0, "Hello...", "This is a notification", notiDetails);
  }

  void checkForNotification() async {
    NotificationAppLaunchDetails? details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
          log("Notification Payload: $payload");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkForNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        child: const Icon(Icons.notification_add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            FacebookBannerAd(
                    bannerSize: BannerSize.STANDARD,
                    placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
                    listener: (result, value) {
                      switch (result) {
                        case BannerAdResult.ERROR:
                          if (kDebugMode) {
                            print("Error: $value");
                          }
                          break;
                        case BannerAdResult.LOADED:
                          if (kDebugMode) {
                            print("Loaded: $value");
                          }
                          break;
                        case BannerAdResult.CLICKED:
                          if (kDebugMode) {
                            print("Clicked: $value");
                          }
                          break;
                        case BannerAdResult.LOGGING_IMPRESSION:
                          if (kDebugMode) {
                            print("Logging Impression: $value");
                          }
                          break;
                      }
                    }),
            const Center(child: Text("Notification!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
          ],
        ),
      ),
    );
  }
}
