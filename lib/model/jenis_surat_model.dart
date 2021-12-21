// To parse this JSON data, do
//
//     final jenisSuratModel = jenisSuratModelFromJson(jsonString);

import 'dart:convert';

JenisSuratModel jenisSuratModelFromJson(String str) => JenisSuratModel.fromJson(json.decode(str));

class JenisSuratModel {
  JenisSuratModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory JenisSuratModel.fromJson(Map<String, dynamic> json) => JenisSuratModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idRt,
    this.jenis,
  });

  int? id;
  int? idRt;
  String? jenis;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    jenis: json["jenis"] == null ? null : json["jenis"],
  );
}
