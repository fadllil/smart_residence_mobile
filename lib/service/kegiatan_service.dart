import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/detail_anggota_model.dart';
import 'package:smart_residence/model/detail_iuran_model.dart';
import 'package:smart_residence/model/detail_iuran_warga_model.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class KegiatanService extends HttpService{
  Future getProses(String id) async{
    Response response = await get('/rt/kegiatan/proses/$id');
    ListKegiatanModel listKegiatanModel = listKegiatanModelFromJson(jsonEncode(response.data));
    return listKegiatanModel;
  }

  Future getSelesai(String id) async{
    Response response = await get('/rt/kegiatan/selesai/$id');
    ListKegiatanModel listKegiatanModel = listKegiatanModelFromJson(jsonEncode(response.data));
    return listKegiatanModel;
  }

  Future getBatal(String id) async{
    Response response = await get('/rt/kegiatan/batal/$id');
    ListKegiatanModel listKegiatanModel = listKegiatanModelFromJson(jsonEncode(response.data));
    return listKegiatanModel;
  }

  Future createKegiatan(Map data) async{
    await post('/rt/kegiatan/create', data);
  }

  Future postSelesai(String id) async{
    await get('/rt/kegiatan/postSelesai/${id}');
  }

  Future postBatal(String id) async{
    await get('/rt/kegiatan/postBatal/${id}');
  }

  Future getDetailAnggota(String id) async{
    Response response = await get('/rt/kegiatan/detail_anggota/$id');
    DetailAnggotaModel detailAnggotaModel = detailAnggotaModelFromJson(jsonEncode(response.data));
    return detailAnggotaModel;
  }

  Future getDetailIuran(String id) async{
    Response response = await get('/rt/kegiatan/detail_iuran/$id');
    DetailIuranModel detailIuranModel = detailIuranModelFromJson(jsonEncode(response.data));
    return detailIuranModel;
  }

  Future getDetailIuranWarga(String id, String id_user) async{
    Response response = await get('/rt/kegiatan/detail_iuran_warga/$id/$id_user');
    DetailIuranWargaModel detailIuranWargaModel = detailIuranWargaModelFromJson(jsonEncode(response.data));
    return detailIuranWargaModel;
  }
}