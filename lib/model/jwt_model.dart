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
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
    id: json["id"] == null ? null : json["id"],
    nama: json["nama"] == null ? null : json["nama"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
