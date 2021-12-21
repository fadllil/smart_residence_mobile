// To parse this JSON data, do
//
//     final keuanganModel = keuanganModelFromJson(jsonString);

import 'dart:convert';

KeuanganModel keuanganModelFromJson(String str) => KeuanganModel.fromJson(json.decode(str));

class KeuanganModel {
  KeuanganModel({
    this.message,
    this.resultss,
    this.code,
  });

  String? message;
  Resultss? resultss;
  int? code;

  factory KeuanganModel.fromJson(Map<String, dynamic> json) => KeuanganModel(
    message: json["message"] == null ? null : json["message"],
    resultss: json["results"] == null ? null : Resultss.fromJson(json["results"]),
    code: json["code"] == null ? null : json["code"],
  );
}

class Resultss {
  Resultss({
    this.id,
    this.idRt,
    this.nominal,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  int? nominal;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Resultss.fromJson(Map<String, dynamic> json) => Resultss(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
