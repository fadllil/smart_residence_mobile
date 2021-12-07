// To parse this JSON data, do
//
//     final listKegiatanModel = listKegiatanModelFromJson(jsonString);

import 'dart:convert';

ListKegiatanModel listKegiatanModelFromJson(String str) => ListKegiatanModel.fromJson(json.decode(str));

class ListKegiatanModel {
  ListKegiatanModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  List<Result>? results;
  int? code;

  factory ListKegiatanModel.fromJson(Map<String, dynamic> json) => ListKegiatanModel(
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    code: json["code"],
  );
}

class Result {
  Result({
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
    this.anggota,
    this.iuran,
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
  List<Anggota>? anggota;
  List<Iuran>? iuran;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    idRt: json["id_rt"],
    nama: json["nama"],
    tglMulai: DateTime.parse(json["tgl_mulai"]),
    tglSelesai: DateTime.parse(json["tgl_selesai"]),
    lokasi: json["lokasi"],
    status: json["status"],
    catatan: json["catatan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    anggota: List<Anggota>.from(json["anggota"].map((x) => Anggota.fromJson(x))),
    iuran: List<Iuran>.from(json["iuran"].map((x) => Iuran.fromJson(x))),
  );
}

class Anggota {
  Anggota({
    this.id,
    this.idKegiatan,
    this.status,
    this.maksimalAnggota,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idKegiatan;
  String? status;
  int? maksimalAnggota;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Anggota.fromJson(Map<String, dynamic> json) => Anggota(
    id: json["id"],
    idKegiatan: json["id_kegiatan"],
    status: json["status"],
    maksimalAnggota: json["maksimal_anggota"] == null ? null : json["maksimal_anggota"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class Iuran {
  Iuran({
    this.id,
    this.idKegiatan,
    this.status,
    this.nominal,
    this.tglTerakhirPembayaran,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idKegiatan;
  String? status;
  int? nominal;
  DateTime? tglTerakhirPembayaran;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Iuran.fromJson(Map<String, dynamic> json) => Iuran(
    id: json["id"],
    idKegiatan: json["id_kegiatan"],
    status: json["status"],
    nominal: json["nominal"] == null ? null : json["nominal"],
    tglTerakhirPembayaran: json["tgl_terakhir_pembayaran"] == null ? null : DateTime.parse(json["tgl_terakhir_pembayaran"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
