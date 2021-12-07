// To parse this JSON data, do
//
//     final listInformasiModel = listInformasiModelFromJson(jsonString);

import 'dart:convert';

ListInformasiModel listInformasiModelFromJson(String str) => ListInformasiModel.fromJson(json.decode(str));

class ListInformasiModel {
  ListInformasiModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory ListInformasiModel.fromJson(Map<String, dynamic> json) => ListInformasiModel(
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idRt,
    this.judul,
    this.isi,
    this.keterangan,
    this.tanggal,
    this.gambar,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  String? judul;
  String? isi;
  String? keterangan;
  DateTime? tanggal;
  String? gambar;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    idRt: json["id_rt"],
    judul: json["judul"],
    isi: json["isi"],
    keterangan: json["keterangan"],
    tanggal: DateTime.parse(json["tanggal"]),
    gambar: json["gambar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
