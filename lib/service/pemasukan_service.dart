import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_pemasukan_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class PemasukanService extends HttpService {
  Future getPemasukan(String id) async {
    Response response = await get('/rt/keuangan/pemasukan/$id');
    ListPemasukanModel listPemasukanModel = listPemasukanModelFromJson(
        jsonEncode(response.data));
    return listPemasukanModel;
  }
}