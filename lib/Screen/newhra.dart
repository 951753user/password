import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HraCalculator extends StatefulWidget {
  const HraCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HraCalculatorState createState() => _HraCalculatorState();
}

class _HraCalculatorState extends State<HraCalculator> {
  int _basicSalary = 0;
  int _hraAmount = 0;
  int _actualrent = 0;

  void _calculateHra() {
    setState(() {
      _hraAmount = _actualrent - _basicSalary * 10 ~/ 100;
      _basicSalary = _basicSalary * 50 ~/ 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HRA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Rent',
                  suffixText: 'INR',
                ),
                onChanged: (value) {
                  setState(() {
                    _actualrent = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Basic Salary',
                  suffixText: 'INR',
                ),
                onChanged: (value) {
                  setState(() {
                    _basicSalary = int.parse(value);
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'HRA',
                  suffixText: 'INR',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _calculateHra,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 16.0),
              Text('HRA Amount: $_hraAmount INR'),
            ],
          ),
        ),
      ),
    );
  }
}
