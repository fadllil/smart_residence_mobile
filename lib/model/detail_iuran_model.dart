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
  List<Result>? results;
  int? code;

  factory DetailIuranModel.fromJson(Map<String, dynamic> json) => DetailIuranModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
  );
}

class Result {
  Result({
    this.id,
    this.idIuran,
    this.idUser,
    this.uang,
    this.tglPembayaran,
    this.status,
    this.gambar,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.nominal,
    this.tglTerakhirPembayaran,
    this.user,
  });

  int? id;
  int? idIuran;
  int? idUser;
  int? uang;
  DateTime? tglPembayaran;
  String? status;
  String? gambar;
  String? keterangan;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? nominal;
  DateTime? tglTerakhirPembayaran;
  User? user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] == null ? null : json["id"],
    idIuran: json["id_iuran"] == null ? null : json["id_iuran"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    uang: json["uang"] == null ? null : json["uang"],
    tglPembayaran: json["tgl_pembayaran"] == null ? null : DateTime.parse(json["tgl_pembayaran"]),
    status: json["status"] == null ? null : json["status"],
    gambar: json["gambar"] == null ? null : json["gambar"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    nominal: json["nominal"] == null ? null : json["nominal"],
    tglTerakhirPembayaran: json["tgl_terakhir_pembayaran"] == null ? null : DateTime.parse(json["tgl_terakhir_pembayaran"]),
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
