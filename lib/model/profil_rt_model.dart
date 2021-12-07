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
    message: json["message"],
    results: Results.fromJson(json["results"]),
    code: json["code"],
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
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  AdminRt? adminRt;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"],
    nama: json["nama"],
    email: json["email"],
    role: json["role"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    adminRt: AdminRt.fromJson(json["admin_rt"]),
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
    id: json["id"],
    idRt: json["id_rt"],
    idUser: json["id_user"],
    nik: json["nik"],
    noHp: json["no_hp"],
    alamat: json["alamat"],
    jabatan: json["jabatan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
