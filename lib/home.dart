// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password/Screen/apicontroller.dart';
import 'package:password/Screen/calc.dart';
import 'package:password/Screen/getstorage.dart';
import 'package:password/Screen/hraCalc.dart';
import 'package:password/Screen/map.dart';
import 'package:password/Screen/newhra.dart';
import 'package:password/Screen/notification.dart';
import 'package:password/Screen/otpscreen.dart';
import 'package:password/Screen/passcodeScreen.dart';
import 'package:password/Screen/reset.dart';
import 'package:password/Screen/verifyotp.dart';
import 'package:password/Screen/webview.dart';
import 'package:password/Screen/zoomtext.dart';

import 'Screen/apiScreen.dart';
import 'Screen/sharescreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiController apiController = Get.put(ApiController());

  bool _isRewardedAdLoaded = false;
  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID ",
      listener: (result, value) {
        if (kDebugMode) {
          print("Rewarded Ad: $result --> $value");
        }
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRewardedVideoAd();
  }

  _showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else if (kDebugMode) {
      print("Rewarded Ad not yet loaded!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // FacebookBannerAd(
            //     bannerSize: BannerSize.STANDARD,
            //     placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
            //     listener: (result, value) {
            //       switch (result) {
            //         case BannerAdResult.ERROR:
            //           if (kDebugMode) {
            //             print("Error: $value");
            //           }
            //           break;
            //         case BannerAdResult.LOADED:
            //           if (kDebugMode) {
            //             print("Loaded: $value");
            //           }
            //           break;
            //         case BannerAdResult.CLICKED:
            //           if (kDebugMode) {
            //             print("Clicked: $value");
            //           }
            //           break;
            //         case BannerAdResult.LOGGING_IMPRESSION:
            //           if (kDebugMode) {
            //             print("Logging Impression: $value");
            //           }
            //           break;
            //       }
            //     }),
            // FacebookBannerAd(
            //     bannerSize: BannerSize.LARGE,
            //     placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
            //     listener: (result, value) {
            //       switch (result) {
            //         case BannerAdResult.ERROR:
            //           if (kDebugMode) {
            //             print("Error: $value");
            //           }
            //           break;
            //         case BannerAdResult.LOADED:
            //           if (kDebugMode) {
            //             print("Loaded: $value");
            //           }
            //           break;
            //         case BannerAdResult.CLICKED:
            //           if (kDebugMode) {
            //             print("Clicked: $value");
            //           }
            //           break;
            //         case BannerAdResult.LOGGING_IMPRESSION:
            //           if (kDebugMode) {
            //             print("Logging Impression: $value");
            //           }
            //           break;
            //       }
            //     }),
            // FacebookBannerAd(
            //     bannerSize: BannerSize.MEDIUM_RECTANGLE,
            //     placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
            //     listener: (result, value) {
            //       if (kDebugMode) {
            //         print("Logging Impression: ${value.invalidated}");
            //       }

            //       switch (result) {
            //         case BannerAdResult.ERROR:
            //           if (kDebugMode) {
            //             print("Error: ${value.invalidated}");
            //           }
            //           break;
            //         case BannerAdResult.LOADED:
            //           if (kDebugMode) {
            //             print("Loaded: ${value.invalidated}");
            //           }
            //           break;
            //         case BannerAdResult.CLICKED:
            //           if (kDebugMode) {
            //             print("Clicked: ${value.invalidated}");
            //           }
            //           break;
            //         case BannerAdResult.LOGGING_IMPRESSION:
            //           if (kDebugMode) {
            //             print("Logging Impression: ${value.invalidated}");
            //           }
            //           break;
            //       }
            //     }),
            Row(
              children: [
                Container(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // FacebookInterstitialAd.loadInterstitialAd(
                            //   placementId:
                            //       "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
                            //   listener: (result, value) {
                            //     if (result == InterstitialAdResult.LOADED) {
                            //       FacebookInterstitialAd.showInterstitialAd();
                            //     }
                            //   },
                            // );
                            Get.to(const Calc());
                          },
                          child: const Text("INTERSTITIAL"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            _showRewardedAd();
                          },
                          child: const Text("REWARDED"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.to(const MyWebView());
                          },
                          child: const Text("Web View"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.to(const Payment());
                          },
                          child: const Text("Payment"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.to(const Get_Storage());
                          },
                          child: const Text("Get Storage"),
                        ),
                        //
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     Get.to(const SLIDE());
                        //   },
                        //   child: const Text("Slider"),
                        // ),
                        ElevatedButton(
                          onPressed: () async {
                            Get.to(const API());
                          },
                          child: const Text("POST Screen"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (FirebaseAuth.instance.currentUser != null) {
                              Get.to(const Passcode());
                            } else {
                              Get.to(const SendOtp());
                            }
                          },
                          child: const Text("OTP"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const Zoom());
                          },
                          child: const Text("Zoom"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const MyHomepage());
                          },
                          // ignore: prefer_const_constructors
                          child: Text("Image pick"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const HRA_Calc());
                          },
                          child: const Text("simple calc"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const HraCalculator());
                          },
                          child: const Text("Hra calc"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const Passcode());
                          },
                          child: const Text("Passcode"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const ShareFilesScreen());
                          },
                          child: const Text("share"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Get.to(const Notify());
                          },
                          child: const Text("Notification"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Get.to(const MAP());
                      },
                      child: const Text("MAP"),
                    ),
                  ],
                ),
              ],
            ),
            //  FacebookNativeAd(
            //   placementId:
            //       "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
            //   adType: NativeAdType.NATIVE_AD,
            //   width: double.infinity,
            //   height: 300,
            //   backgroundColor: Colors.blueGrey[200],
            //   titleColor: Colors.white,
            //   descriptionColor: Colors.white,
            //   buttonColor: Colors.deepPurple,
            //   buttonTitleColor: Colors.white,
            //   buttonBorderColor: Colors.white,
            //   keepAlive:
            //       true, //set true if you do not want adview to refresh on widget rebuild
            //   keepExpandedWhileLoading:
            //       false, // set false if you want to collapse the native ad view when the ad is loading
            //   expandAnimationDuraion:
            //       300, //in milliseconds. Expands the adview with animation when ad is loaded
            //   listener: (result, value) {
            //     if (kDebugMode) {
            //       print("Native Ad: $result --> $value");
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
