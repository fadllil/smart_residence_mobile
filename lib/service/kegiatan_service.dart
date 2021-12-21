import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/berpartisipasi_peserta_model.dart';
import 'package:smart_residence/model/detail_anggota_model.dart';
import 'package:smart_residence/model/detail_iuran_model.dart';
import 'package:smart_residence/model/detail_iuran_warga_model.dart';
import 'package:smart_residence/model/list_data_kegiatan_model.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class KegiatanService extends HttpService{
  Future getKegiatan(String id) async{
    Response response = await get('/rt/kegiatan/$id');
    ListDataKegiatanModel listDataKegiatanModel = listDataKegiatanModelFromJson(jsonEncode(response.data));
    return listDataKegiatanModel;
  }

  Future kegiatan(String id, String status) async{
    Response response = await get('/rt/kegiatan/get/$id?status=$status');
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

  Future getDetailIuranBelumBayar(String id) async{
    Response response = await get('/rt/kegiatan/detail_iuran/belum_bayar/$id');
    DetailIuranModel detailIuranModel = detailIuranModelFromJson(jsonEncode(response.data));
    return detailIuranModel;
  }

  Future getDetailIuranMenungguValidasi(String id) async{
    Response response = await get('/rt/kegiatan/detail_iuran/menunggu_validasi/$id');
    DetailIuranModel detailIuranModel = detailIuranModelFromJson(jsonEncode(response.data));
    return detailIuranModel;
  }

  Future getDetailIuranSudahBayar(String id) async{
    Response response = await get('/rt/kegiatan/detail_iuran/sudah_bayar/$id');
    DetailIuranModel detailIuranModel = detailIuranModelFromJson(jsonEncode(response.data));
    return detailIuranModel;
  }

  Future getDetailIuranWarga(String id, String id_user) async{
    Response response = await get('/rt/kegiatan/detail_iuran_warga/$id/$id_user');
    DetailIuranWargaModel detailIuranWargaModel = detailIuranWargaModelFromJson(jsonEncode(response.data));
    return detailIuranWargaModel;
  }

  Future postFoto(FormData data)async{
    Response response = await post('/rt/upload-file/buktiIuran', data);
    return response.data['results'];
  }

  Future bayar(Map data) async{
    await post('/warga/kegiatan/iuran/bayar', data);
  }

  Future bayarDonasi(Map data) async{
    await post('/warga/kegiatan/iuran/bayar-donasi', data);
  }

  Future validasi(String id) async{
    await get('/rt/kegiatan/iuran/validasi/$id');
  }

  Future berpartisipasiAnggota(String id, String id_user) async{
    Response response = await get('/warga/kegiatan/peserta-berpartisipasi/$id?user=$id_user');
    BerpartisipasiPesertaModel berpartisipasiPesertaModel = berpartisipasiPesertaModelFromJson(jsonEncode(response.data));
    return berpartisipasiPesertaModel;
  }

  Future joinPeserta(Map data) async{
    await post('/warga/kegiatan/peserta-join', data);
  }
}