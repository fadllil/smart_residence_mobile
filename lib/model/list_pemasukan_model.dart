// To parse this JSON data, do
//
//     final listPemasukanModel = listPemasukanModelFromJson(jsonString);

import 'dart:convert';

ListPemasukanModel listPemasukanModelFromJson(String str) => ListPemasukanModel.fromJson(json.decode(str));

class ListPemasukanModel {
  ListPemasukanModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory ListPemasukanModel.fromJson(Map<String, dynamic> json) => ListPemasukanModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idRt,
    this.idKegiatan,
    this.nominal,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.kegiatan,
  });

  int? id;
  int? idRt;
  int? idKegiatan;
  int? nominal;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;
  Kegiatan? kegiatan;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    kegiatan: json["kegiatan"] == null ? null : Kegiatan.fromJson(json["kegiatan"]),
  );
}

class Kegiatan {
  Kegiatan({
    this.id,
    this.idRt,
    this.nama,
    this.tglMulai,
    this.tglSelesai,
    this.lokasi,
    this.status,
    this.catatan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  String? nama;
  DateTime? tglMulai;
  DateTime? tglSelesai;
  String? lokasi;
  String? status;
  String? catatan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Kegiatan.fromJson(Map<String, dynamic> json) => Kegiatan(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    nama: json["nama"] == null ? null : json["nama"],
    tglMulai: json["tgl_mulai"] == null ? null : DateTime.parse(json["tgl_mulai"]),
    tglSelesai: json["tgl_selesai"] == null ? null : DateTime.parse(json["tgl_selesai"]),
    lokasi: json["lokasi"] == null ? null : json["lokasi"],
    status: json["status"] == null ? null : json["status"],
    catatan: json["catatan"] == null ? null : json["catatan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
