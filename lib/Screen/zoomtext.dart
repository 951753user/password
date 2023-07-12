import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  State<Zoom> createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  Offset dragGesturePositon = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Expanded(
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) => setState(
                        () {
                          dragGesturePositon = details.localPosition;
                        },
                      ),
                      child: Container(
                        height: 702,
                        // width: 500,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://0.academia-photos.com/attachment_thumbnails/32856377/mini_magick20190409-14761-11gcw8y.png?1554800201"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: dragGesturePositon.dx,
                      top: dragGesturePositon.dy,
                      child: const RawMagnifier(
                        decoration: MagnifierDecoration(
                          shape: CircleBorder(
                            side: BorderSide(color: Colors.pink, width: 3),
                          ),
                        ),
                        size: Size(100, 100),
                        magnificationScale: 2,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
