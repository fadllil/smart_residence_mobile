import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/jenis_surat_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class JenisSuratService extends HttpService {
  Future getSurat(String id) async {
    Response response = await get('/rt/jenis-surat/$id');
    JenisSuratModel jenisSuratModel = jenisSuratModelFromJson(
        jsonEncode(response.data));
    return jenisSuratModel;
  }

  Future create(Map data) async{
    await post('/rt/jenis-surat/create', data);
  }

  Future update(Map data) async{
    await post('/rt/jenis-surat/update', data);
  }

  Future delete(String id) async{
    await get('/rt/jenis-surat/delete/$id');
  }
}