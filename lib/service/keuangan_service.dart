import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/keuangan_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class KeuanganService extends HttpService {
  Future getKeuangan(String id) async {
    Response response = await get('/rt/keuangan/$id');
    KeuanganModel keuanganModel = keuanganModelFromJson(
        jsonEncode(response.data));
    return keuanganModel;
  }
}