// ignore_for_file: deprecated_member_use


import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareFilesScreen extends StatefulWidget {
  const ShareFilesScreen({Key? key}) : super(key: key);

  @override
  State<ShareFilesScreen> createState() => _ShareFilesScreenState();
}

class _ShareFilesScreenState extends State<ShareFilesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Files Demo'),
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
            ElevatedButton(
              onPressed: () async {
                var files = [
                  '/storage/emulated/0/Download/Subject_Head_Wise_Student_Result_Report (1) (1) (1).pdf',
                  '/storage/emulated/0/Documents/PDF maker/new1.pdf',
                  '/storage/emulated/0/Download/Subject_Head_Wise_Student_Result_Report (1).pdf'
                ];
                await Share.shareFiles(files);
              },
              child: const Text('Share Multiple Files'),
            ),
          ],
        ),
      ),
    );
  }
}
