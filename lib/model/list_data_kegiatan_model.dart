// To parse this JSON data, do
//
//     final listDataKegiatanModel = listDataKegiatanModelFromJson(jsonString);

import 'dart:convert';

ListDataKegiatanModel listDataKegiatanModelFromJson(String str) => ListDataKegiatanModel.fromJson(json.decode(str));

class ListDataKegiatanModel {
  ListDataKegiatanModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Results>? results;
  int? code;

  factory ListDataKegiatanModel.fromJson(Map<String, dynamic> json) => ListDataKegiatanModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Results {
  Results({
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

  factory Results.fromJson(Map<String, dynamic> json) => Results(
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
