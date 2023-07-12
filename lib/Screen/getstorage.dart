// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password/Screen/apicontroller.dart';
import 'package:password/main.dart';

class Get_Storage extends StatefulWidget {
  const Get_Storage({Key? key}) : super(key: key);

  @override
  State<Get_Storage> createState() => _Get_StorageState();
}

class _Get_StorageState extends State<Get_Storage> {
  ApiController apiController = Get.put(ApiController());

  TextEditingController txtsave = TextEditingController();
  List data = [];

  // void save(List<String> list) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList(listKey, list);
  // }
  // Future<List<String>?> read() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.getStringList(listKey);
  // }

  String listKey = "listKey";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Storage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            TextField(
              controller: txtsave,
            ),
            ElevatedButton(
                onPressed: () async {
                  var alldata = txtsave.text;
                  await storage.write(
                      key: "save", value: jsonEncode(alldata));
                  var reminderTime = await storage.read(key: "save");
                  data = jsonDecode(reminderTime.toString());

                  if (kDebugMode) {
                    print("------->>>>  Save List data  $data");
                  }
                },
                child: const Text("Save")),
            ElevatedButton(
              onPressed: () {
                storage.delete(key: "save");
                if (kDebugMode) {
                  print("------->>>>  Remove  List data  ${apiController.data}");
                }
              },
              child: const Text("Remove"),
            ),
          ],
        ),
      ),
    );
  }
}
