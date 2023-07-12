import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/Model.dart';

class ApiController extends GetxController {
  String data = '';
  List<String> alldata = [];

  Future getapi() async {
    String url = "https://jsonplaceholder.typicode.com/posts";

    var response = await http.get(Uri.parse(url));

    var result = json.decode(response.body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("=========================${response.statusCode}");
      }
    } else {
      if (kDebugMode) {
        print("===========$response");
      }
    }
    return result.map(
          (e) => Model.fromJson(e),
        )
        .toList();
  }

// Future<PanModel> getapi(String pan) async {
//   if (kDebugMode) {
//     print("------$pan");
//   }
//   String url =
//       "https://pan-card-verification-at-lowest-price.p.rapidapi.com/verifyPan/$pan";
//
//   var response = await http.get(Uri.parse(url), headers: {
//     "X-RapidAPI-Key": "5ebda0a9e2msheb3ba1aea82fffdp151415jsn6c46b7031eb7",
//     "X-RapidAPI-Host": "pan-card-verification-at-lowest-price.p.rapidapi.com"
//   });
//   if (kDebugMode) {
//     print("=========================${response.body}");
//   }
//   if (kDebugMode) {
//     print("=========================${response.statusCode}");
//   }
//
//   var result = json.decode(response.body);
//
//   if (response.statusCode == HttpStatus.ok) {
//     // return result;
//     if (kDebugMode) {
//       print("==============done");
//     }
//   } else {
//     debugPrint("===========$response");
//   }
//   return PanModel.fromJson(result);
// }
}
