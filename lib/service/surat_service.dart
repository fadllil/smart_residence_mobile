import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_surat_model.dart';
import 'package:smart_residence/model/list_surat_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class SuratService extends HttpService {
  Future getSurat(String id, String status) async {
    Response response = await get('/rt/surat/$id?status=$status');
    ListSuratModel listSuratModel = listSuratModelFromJson(
        jsonEncode(response.data));
    return listSuratModel;
  }

  Future getPengajuanSurat(String id, String status) async {
    Response response = await get('/warga/surat/$id?status=$status');
    ListSuratWargaModel listSuratWargaModel = listSuratWargaModelFromJson(
        jsonEncode(response.data));
    return listSuratWargaModel;
  }

  Future createSuratWarga(Map data) async{
    await post('/warga/surat/create', data);
  }
}