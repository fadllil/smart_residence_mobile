// To parse this JSON data, do
//
//     final jwtModel = jwtModelFromJson(jsonString);

import 'dart:convert';

JwtModel jwtModelFromJson(String str) => JwtModel.fromJson(json.decode(str));

class JwtModel {
  JwtModel({
    this.iss,
    this.sub,
    this.iat,
  });

  String? iss;
  Sub? sub;
  int? iat;

  factory JwtModel.fromJson(Map<String, dynamic> json) => JwtModel(
    iss: json["iss"] == null ? null : json["iss"],
    sub: json["sub"] == null ? null : Sub.fromJson(json["sub"]),
    iat: json["iat"] == null ? null : json["iat"],
  );
}

class Sub {
  Sub({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.adminRt,
    this.warga,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  AdminRt? adminRt;
  Warga? warga;

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    adminRt: json["admin_rt"] == null ? null : AdminRt.fromJson(json["admin_rt"]),
    warga: json["warga"] == null ? null : Warga.fromJson(json["warga"]),
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
