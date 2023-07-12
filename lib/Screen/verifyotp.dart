// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
  
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Tutorial'),
      ),
      body: Center(
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
            ElevatedButton(
              onPressed: () async {
                await makePayment();
                },
              child: const Text("Pay"),

            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('100', 'INR'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(

              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret:
                      'sk_test_51MmX0qSGYQCrC9DTfiNlXuO5fTlYhBgbejJ6KIvuSljrEr642E5ubtFN1ayv3cDjY95PMyW77u8sLfyat0B3Lvwk00rNTMBBtL',
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'] ?? '',


                  // applePay: PaymentSheetApplePay(merchantCountryCode: 'INR'),
                  // googlePay: PaymentSheetGooglePay(merchantCountryCode: 'INR'),
                  //testEnv: true,
                  customFlow: true,
                  style: ThemeMode.dark,
                  // merchantCountryCode: 'US',
                  merchantDisplayName: 'Kashif')
      )
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      if (kDebugMode) {
        print('Payment exception:$e$s');
      }
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              //       parameters: PresentPaymentSheetParameters(
              // clientSecret: paymentIntentData!['client_secret'],
              // confirmPayment: true,
              // )
              )
          .then((newValue) {
        if (kDebugMode) {
          print('payment intent${paymentIntentData!['id']}');
        }
        if (kDebugMode) {
          print('payment intent${paymentIntentData!['client_secret']}');
        }
        if (kDebugMode) {
          print('payment intent${paymentIntentData!['amount']}');
        }
        if (kDebugMode) {
          print('payment intent$paymentIntentData');
        }
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Exception/DISPLAYPAYMENTSHEET==> $e');
      }
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('60'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      if (kDebugMode) {
        print(body);
      }
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51MmX0qSGYQCrC9DTfiNlXuO5fTlYhBgbejJ6KIvuSljrEr642E5ubtFN1ayv3cDjY95PMyW77u8sLfyat0B3Lvwk00rNTMBBtL',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      if (kDebugMode) {
        print('Create Intent reponse ===> ${response.body.toString()}');
      }
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('err charging user: ${err.toString()}');
      }
    }
  }

  calculateAmount(String amount) {
    final a = amount;
    return a.toString();
  }
}
