// To parse this JSON data, do
//
//     final berpartisipasiPesertaModel = berpartisipasiPesertaModelFromJson(jsonString);

import 'dart:convert';

BerpartisipasiPesertaModel berpartisipasiPesertaModelFromJson(String str) => BerpartisipasiPesertaModel.fromJson(json.decode(str));

class BerpartisipasiPesertaModel {
  BerpartisipasiPesertaModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory BerpartisipasiPesertaModel.fromJson(Map<String, dynamic> json) => BerpartisipasiPesertaModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
    code: json["code"] == null ? null : json["code"],
  );
}

class Results {
  Results({
    this.id,
    this.idKegiatan,
    this.status,
    this.maksimalAnggota,
    this.createdAt,
    this.updatedAt,
    this.berpartisipasi,
    this.user,
  });

  int? id;
  int? idKegiatan;
  String? status;
  int? maksimalAnggota;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? berpartisipasi;
  dynamic user;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    status: json["status"] == null ? null : json["status"],
    maksimalAnggota: json["maksimal_anggota"] == null ? null : json["maksimal_anggota"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    berpartisipasi: json["berpartisipasi"] == null ? null : json["berpartisipasi"],
    user: json["user"],
  );
}
