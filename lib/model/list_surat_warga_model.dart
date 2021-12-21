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
    this.idJenisSurat,
    this.keterangan,
    this.status,
    this.tanggal,
    this.createdAt,
    this.updatedAt,
    this.jenisSurat,
  });

  int? id;
  int? idRt;
  int? idUser;
  int? idJenisSurat;
  String? keterangan;
  String? status;
  DateTime? tanggal;
  DateTime? createdAt;
  DateTime? updatedAt;
  JenisSurat? jenisSurat;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    idJenisSurat: json["id_jenis_surat"] == null ? null : json["id_jenis_surat"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    status: json["status"] == null ? null : json["status"],
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    jenisSurat: json["jenis_surat"] == null ? null : JenisSurat.fromJson(json["jenis_surat"]),
  );
}

class JenisSurat {
  JenisSurat({
    this.id,
    this.idRt,
    this.jenis,
  });

  int? id;
  int? idRt;
  String? jenis;

  factory JenisSurat.fromJson(Map<String, dynamic> json) => JenisSurat(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    jenis: json["jenis"] == null ? null : json["jenis"],
  );
}
