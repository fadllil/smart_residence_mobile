// To parse this JSON data, do
//
//     final listWargaModel = listWargaModelFromJson(jsonString);

import 'dart:convert';

ListWargaModel listWargaModelFromJson(String str) => ListWargaModel.fromJson(json.decode(str));

class ListWargaModel {
  ListWargaModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory ListWargaModel.fromJson(Map<String, dynamic> json) => ListWargaModel(
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"],
  );
}

class Result {
  Result({
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
    this.user,
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
  User? user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    idRt: json["id_rt"],
    idUser: json["id_user"],
    nik: json["nik"],
    alamat: json["alamat"],
    noHp: json["no_hp"],
    jmlAnggotaKeluarga: json["jml_anggota_keluarga"],
    noKk: json["no_kk"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
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
    id: json["id"],
    nama: json["nama"],
    email: json["email"],
    role: json["role"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
