// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_otp/flutter_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:password/Screen/passcodeScreen.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  TextEditingController otpController = TextEditingController();
  TextEditingController numController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  // FlutterOtp otp = FlutterOtp();

  String phoneNumber = "9586919587";
  int minNumber = 1000;
  int maxNumber = 6000;
  String countryCode = "+91";

  String verificationId = "";
  late TwilioFlutter twilioFlutter;
  var sentOTP;

  sendotp() async {
    twilioFlutter = TwilioFlutter(
        accountSid: "AC6f1f083faf14848352c443e7ce42f415",
        authToken: "a5e2768813ad39d5bcfe1012278522c8",
        twilioNumber: "+15075568983");

    var rnd = Random();

    var digits = rnd.nextInt(900000) + 100000;

    sentOTP = digits;

    // otp.sendOtp(phoneNumber, 'OTP is : $sentOTP ',
    //     minNumber, maxNumber, countryCode);

    if (kDebugMode) {
      print(sentOTP);
    }

    twilioFlutter.sendSMS(
        toNumber: numController.text,
        messageBody: 'Hello This is 6 digit otp code to verify phone $digits');
  }

  verifyOTP() {
    if (sentOTP.toString() == otpController.text) {
      Fluttertoast.showToast(
          msg: "OTP Verified SuccessFully!", backgroundColor: Colors.green).then((value) => Get.off(const Passcode()));
    } else {
      Fluttertoast.showToast(
          msg: "OTP didn't match!", backgroundColor: Colors.red);
    }
  }

  @override
  void initState() {
    numController.text = "+91";
    super.initState();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Get.off(const Passcode());
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("LOGIN"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText: 'Enter valid number'),
                  controller: numController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter valid password'),
                  controller: otpController,
                ),
              ),
              TextButton(
                onPressed: () {
                  sendotp();
                },
                child: const Text("Fetch OTP"),
              ),
              TextButton(
                  onPressed: () {
                    verifyOTP();
                  },
                  child: const Text("Send"))
            ],
          ),
        ));
  }

  // Future<void> verify() async {
  //   PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: otpController.text);
  //
  //   signInWithPhoneAuthCredential(phoneAuthCredential);
  // }

  // Future<void> fetchotp() async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: numController.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         if (kDebugMode) {
  //           print('The provided phone number is not valid.');
  //         }
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       this.verificationId = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  //   // await  auth.setSettings(appVerificationDisabledForTesting: true);
  //
  // }
}

//
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_otp/flutter_otp.dart';
// import 'package:get/get.dart';
// import 'package:password/verifyotp.dart';
//
// // Now instantiate FlutterOtp class in order to call sendOtp function
// FlutterOtp otp = FlutterOtp();
//
// class SendOtp extends StatelessWidget {
//   TextEditingController txtotp = TextEditingController();
//   TextEditingController txtmatch = TextEditingController();
//
//   var rndnumber = "";
//   var match = "";
//   var passmatch = "";
//
//   void otpgenerate() {
//     rndnumber = "";
//     var rnd = Random();
//     for (var i = 0; i < 6; i++) {
//       rndnumber = rndnumber + rnd.nextInt(9).toString();
//     }
//     // print("===========================================$rndnumber");
//   }
//
//   String phoneNumber = ""; //enter your 10 digit number
//   int minNumber = 1000;
//   int maxNumber = 6000;
//   String countryCode =
//       "+91"; // give your country code if not it will take +1 as default
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("send otp using flutter_otp ")),
//       body: Container(
//         child: Center(
//             child: Column(
//           children: [
//             TextField(
//               controller: txtotp,
//
//             ),
//             ElevatedButton(
//               child: Text("Send"),
//               onPressed: () {
//                 phoneNumber = txtotp.text;
//
//                 otpgenerate();
//                 // call sentOtp function and pass the parameters
//
//                 otp.sendOtp(phoneNumber, 'OTP is : $rndnumber ', minNumber,
//                     maxNumber, countryCode);
//               },
//             ),
//             TextField(
//               controller: txtmatch,
//               onChanged: (value) {
//                 passmatch = value;
//               },
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   print("===========$rndnumber");
//                   print("=========-------==$passmatch");
//                   if (rndnumber == passmatch) {
//                     print("======================");
//                     Get.to(VerifyOTPScreen());
//                   }
//                 },
//                 child: Text("Next"))
//           ],
//         )),
//       ),
//     );
//   }
// }
