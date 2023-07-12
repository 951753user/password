// To parse this JSON data, do
//
//     final panModel = panModelFromJson(jsonString);

import 'dart:convert';

PanModel panModelFromJson(String str) => PanModel.fromJson(json.decode(str));

String panModelToJson(PanModel data) => json.encode(data.toJson());

class PanModel {
  PanModel({
    this.entity,
    this.pan,
    this.firstName,
    this.middleName,
    this.lastName,
    this.error,
    this.message,
    this.status,
  });

  String? entity;
  String? pan;
  String? firstName;
  String? middleName;
  String? lastName;
  String? error;
  String? message;
  int? status;


  factory PanModel.fromJson(Map<String, dynamic> json) => PanModel(
    entity: json["@entity"],
    pan: json["pan"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    error: json["error"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "@entity": entity,
    "pan": pan,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "error": error,
    "message": message,
    "status": status,
  };
}
