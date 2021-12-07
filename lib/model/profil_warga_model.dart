// To parse this JSON data, do
//
//     final profilWargaModel = profilWargaModelFromJson(jsonString);

import 'dart:convert';

ProfilWargaModel profilWargaModelFromJson(String str) => ProfilWargaModel.fromJson(json.decode(str));

class ProfilWargaModel {
  ProfilWargaModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory ProfilWargaModel.fromJson(Map<String, dynamic> json) => ProfilWargaModel(
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
    this.warga,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Warga? warga;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    warga: json["warga"] == null ? null : Warga.fromJson(json["warga"]),
  );
}

class Warga {
  Warga({
    this.id,
    this.idRt,
    this.idUser,
    this.nik,
    this.alamat,
    this.noHp,
    this.jmlAnggotaKeluarga,
    this.noKk,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idRt;
  int? idUser;
  String? nik;
  String? alamat;
  String? noHp;
  String? jmlAnggotaKeluarga;
  String? noKk;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Warga.fromJson(Map<String, dynamic> json) => Warga(
    id: json["id"] == null ? null : json["id"],
    idRt: json["id_rt"] == null ? null : json["id_rt"],
    idUser: json["id_user"] == null ? null : json["id_user"],
    nik: json["nik"] == null ? null : json["nik"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    noHp: json["no_hp"] == null ? null : json["no_hp"],
    jmlAnggotaKeluarga: json["jml_anggota_keluarga"] == null ? null : json["jml_anggota_keluarga"],
    noKk: json["no_kk"] == null ? null : json["no_kk"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
