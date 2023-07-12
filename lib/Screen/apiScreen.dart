// ignore_for_file: file_names

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password/Screen/apicontroller.dart';

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API DEMO"),
      ),
      body: Column(
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
          Expanded(
            child: FutureBuilder<dynamic>(
              future: apiController.getapi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (kDebugMode) {
                    print("-=-=-=-");
                  }
                  List data = snapshot.data;
                  return ListView.builder(itemCount: data.length,
                      itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${data[index].userId}"),
                    );
                  });
                } else if (snapshot.hasError) {
                  if (kDebugMode) {
                    print("${snapshot.error}");
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
