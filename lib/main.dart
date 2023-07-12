// ignore_for_file: prefer_const_declarations

import 'dart:developer';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest_10y.dart';

import 'home.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final box = GetStorage();
final storage = const FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeTimeZones();

  FacebookAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
      
            );

  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true);

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings, iOS: iosSettings);

  bool? initialized = await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, onDidReceiveNotificationResponse: (response) {
    log(response.payload.toString());
  });

  log("Notifications: $initialized");

  Stripe.publishableKey =
      'pk_test_51MmX0qSGYQCrC9DTj1LwzrMafcBuGoP3Ocr7yHYcijKqvXO6YL1XT617bWntf2r3zhdJ0gGYfpSVvLSVZKMNzdIQ00Zc95nHKN';

  await Stripe.instance.applySettings();

  await Firebase.initializeApp();

  runApp(
    // ignore: prefer_const_constructors
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch:  Colors.red),
      home: const Home(),
    ),
  );
}
