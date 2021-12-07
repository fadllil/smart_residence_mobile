import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_surat_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class SuratService extends HttpService {
  Future getSuratKeteranganWarga(String id) async {
    Response response = await get('/warga/surat/keterangan/$id');
    ListSuratWargaModel listSuratWargaModel = listSuratWargaModelFromJson(
        jsonEncode(response.data));
    return listSuratWargaModel;
  }

  Future getSuratPengantarWarga(String id) async {
    Response response = await get('/warga/surat/pengantar/$id');
    ListSuratWargaModel listSuratWargaModel = listSuratWargaModelFromJson(
        jsonEncode(response.data));
    return listSuratWargaModel;
  }

  Future createSuratWarga(Map data) async{
    await post('/warga/surat/create', data);
  }
}