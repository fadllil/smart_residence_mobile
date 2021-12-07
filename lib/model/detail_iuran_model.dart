// To parse this JSON data, do
//
//     final detailIuranModel = detailIuranModelFromJson(jsonString);

import 'dart:convert';

DetailIuranModel detailIuranModelFromJson(String str) => DetailIuranModel.fromJson(json.decode(str));

class DetailIuranModel {
  DetailIuranModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory DetailIuranModel.fromJson(Map<String, dynamic> json) => DetailIuranModel(
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
    this.nominal,
    this.tglTerakhirPembayaran,
    this.createdAt,
    this.updatedAt,
    this.detailIuran,
  });

  int? id;
  int? idKegiatan;
  String? status;
  int? nominal;
  DateTime? tglTerakhirPembayaran;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<DetailIuran>? detailIuran;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    status: json["status"] == null ? null : json["status"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    tglTerakhirPembayaran: json["tgl_terakhir_pembayaran"] == null ? null : DateTime.parse(json["tgl_terakhir_pembayaran"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    detailIuran: json["detail_iuran"] == null ? null : List<DetailIuran>.from(json["detail_iuran"].map((x) => DetailIuran.fromJson(x))),
  );
}

class DetailIuran {
  DetailIuran({
    this.id,
    this.idIuran,
    this.idUser,
    this.uang,
    this.tglPembayaran,
    this.status,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? idIuran;
  int? idUser;
  dynamic uang;
  dynamic tglPembayaran;
  String? status;
  dynamic keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory DetailIuran.fromJson(Map<String, dynamic> json) => DetailIuran(
    id: json["id"] == null ? null : json["id"],
    idIuran: json["id_iuran"] == null ? null : json["id_iuran"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    uang: json["uang"],
    tglPembayaran: json["tgl_pembayaran"],
    status: json["status"] == null ? null : json["status"],
    keterangan: json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}

class User {
  User({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
