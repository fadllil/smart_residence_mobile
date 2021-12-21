// To parse this JSON data, do
//
//     final profilRtModel = profilRtModelFromJson(jsonString);

import 'dart:convert';

ProfilRtModel profilRtModelFromJson(String str) => ProfilRtModel.fromJson(json.decode(str));

class ProfilRtModel {
  ProfilRtModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory ProfilRtModel.fromJson(Map<String, dynamic> json) => ProfilRtModel(
    message: json["message"] == null ? null : json["message"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
    code: json["code"] == null ? null : json["code"],
  );
}

class Results {
  Results({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.adminRt,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  AdminRt? adminRt;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    adminRt: json["admin_rt"] == null ? null : AdminRt.fromJson(json["admin_rt"]),
  );
}

class AdminRt {
  AdminRt({
    this.id,
    this.idRt,
    this.idUser,
    this.nik,
    this.noHp,
    this.alamat,
    this.jabatan,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  int? idUser;
  String? nik;
  String? noHp;
  String? alamat;
  String? jabatan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AdminRt.fromJson(Map<String, dynamic> json) => AdminRt(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    nik: json["nik"] == null ? null : json["nik"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    jabatan: json["jabatan"] == null ? null : json["jabatan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
