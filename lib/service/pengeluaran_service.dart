import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_pengeluaran_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class PengeluaranService extends HttpService {
  Future getPengeluaran(String id) async {
    Response response = await get('/rt/keuangan/pengeluaran/$id');
    ListPengeluaranModel listPengeluaranModel = listPengeluaranModelFromJson(
        jsonEncode(response.data));
    return listPengeluaranModel;
  }
  Future createPengeluaran(Map data) async{
    await post('/rt/keuangan/pengeluaran/create', data);
  }
}