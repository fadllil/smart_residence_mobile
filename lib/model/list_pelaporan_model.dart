// To parse this JSON data, do
//
//     final listPelaporanModel = listPelaporanModelFromJson(jsonString);

import 'dart:convert';

ListPelaporanModel listPelaporanModelFromJson(String str) => ListPelaporanModel.fromJson(json.decode(str));

class ListPelaporanModel {
  ListPelaporanModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory ListPelaporanModel.fromJson(Map<String, dynamic> json) => ListPelaporanModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idRt,
    this.idUser,
    this.judul,
    this.isi,
    this.keterangan,
    this.tglDiproses,
    this.gambar,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  int? idUser;
  String? judul;
  String? isi;
  String? keterangan;
  DateTime? tglDiproses;
  String? gambar;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    judul: json["judul"] == null ? null : json["judul"],
    isi: json["isi"] == null ? null : json["isi"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    tglDiproses: json["tgl_diproses"] == null ? null : DateTime.parse(json["tgl_diproses"]),
    gambar: json["gambar"] == null ? null : json["gambar"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
