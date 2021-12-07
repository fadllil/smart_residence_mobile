// To parse this JSON data, do
//
//     final detailIuranWargaModel = detailIuranWargaModelFromJson(jsonString);

import 'dart:convert';

DetailIuranWargaModel detailIuranWargaModelFromJson(String str) => DetailIuranWargaModel.fromJson(json.decode(str));

class DetailIuranWargaModel {
  DetailIuranWargaModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory DetailIuranWargaModel.fromJson(Map<String, dynamic> json) => DetailIuranWargaModel(
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
    this.getIuran,
    this.kegiatan,
  });

  int? id;
  int? idKegiatan;
  String? status;
  int? nominal;
  DateTime? tglTerakhirPembayaran;
  DateTime? createdAt;
  DateTime? updatedAt;
  GetIuran? getIuran;
  Kegiatan? kegiatan;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    idKegiatan: json["id_kegiatan"] == null ? null : json["id_kegiatan"],
    status: json["status"] == null ? null : json["status"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    tglTerakhirPembayaran: json["tgl_terakhir_pembayaran"] == null ? null : DateTime.parse(json["tgl_terakhir_pembayaran"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    getIuran: json["get_iuran"] == null ? null : GetIuran.fromJson(json["get_iuran"]),
    kegiatan: json["kegiatan"] == null ? null : Kegiatan.fromJson(json["kegiatan"]),
  );
}

class GetIuran {
  GetIuran({
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

  factory GetIuran.fromJson(Map<String, dynamic> json) => GetIuran(
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
