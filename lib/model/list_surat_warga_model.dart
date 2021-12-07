// To parse this JSON data, do
//
//     final listSuratWargaModel = listSuratWargaModelFromJson(jsonString);

import 'dart:convert';

ListSuratWargaModel listSuratWargaModelFromJson(String str) => ListSuratWargaModel.fromJson(json.decode(str));

class ListSuratWargaModel {
  ListSuratWargaModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory ListSuratWargaModel.fromJson(Map<String, dynamic> json) => ListSuratWargaModel(
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
    this.jenis,
    this.keterangan,
    this.tanggal,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  int? idUser;
  String? jenis;
  String? keterangan;
  DateTime? tanggal;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    jenis: json["jenis"] == null ? null : json["jenis"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
