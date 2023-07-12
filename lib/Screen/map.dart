import 'dart:async';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MAP extends StatefulWidget {
  const MAP({super.key});

  @override
  State<MAP> createState() => _MAPState();
}

class _MAPState extends State<MAP> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 4,
  );

  List<Marker> marker = [];

  Future<Position> getuserlocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadlocation() {
    getuserlocation().then(
      (value) async {
        if (kDebugMode) {
          print("my current location");
        }
        if (kDebugMode) {
          print("${value.latitude} ${value.longitude}");
        }
        final Uint8List markerIcon =
            await getBytesFromAsset('asset/image/boy.png', 80);

        marker.add(Marker(
          markerId: const MarkerId("asdfghjkl852"),
          position: LatLng(value.latitude, value.longitude),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: const InfoWindow(title: "CURRENT LOCATION"),
        ));
        CameraPosition cameraPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude), zoom: 15);
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadlocation();
    // marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                mapType: MapType.normal,
                myLocationEnabled: true,
                markers: Set<Marker>.of(marker),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Get.to(const GoogleSearchPlacesApi());
        //   },
        //   child: const Icon(Icons.search),
        // ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.centerFloat
      ),
    );
  }
}
