// ignore_for_file: file_names

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:local_auth/local_auth.dart';

import 'otpscreen.dart';

class Passcode extends StatefulWidget {
  const Passcode({Key? key}) : super(key: key);

  @override
  State<Passcode> createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate',

      // biometricOnly: true,
    );
    if (didAuthenticate) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hide Screen"),
      ),
      body:  Center(
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
            ElevatedButton(onPressed: (){
              _signOut();
              
            }, child: const Text("SIGN OUT")),
          ],
        )
      ),
    );
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Get.off(const SendOtp()));
  }
}
