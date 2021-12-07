import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_informasi_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class InformasiService extends HttpService {
  Future getInformasi(String id) async {
    Response response = await get('/rt/informasi/$id');
    ListInformasiModel listInformasiModel = listInformasiModelFromJson(
        jsonEncode(response.data));
    return listInformasiModel;
  }

  Future createInformasi(Map data) async{
    await post('/rt/informasi/create', data);
  }

  Future postFoto(FormData data)async{
    Response response = await post('/rt/upload-file/informasi', data);
    return response.data['results'];
  }

  Future updateInformasi(Map data) async{
    await post('/rt/informasi/update', data);
  }

  Future deleteInformasi(String id) async{
    await get('/rt/informasi/delete/$id');
  }
}