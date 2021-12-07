import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class WargaService extends HttpService{
  Future getDataWarga(String id) async{
    Response response = await get('/rt/warga/aktif/$id');
    ListWargaModel listWargaModel = listWargaModelFromJson(jsonEncode(response.data));
    return listWargaModel;
  }

  Future getDataWargaNonAktif(String id) async{
    Response response = await get('/rt/warga/tidak_aktif/$id');
    ListWargaModel listWargaModel = listWargaModelFromJson(jsonEncode(response.data));
    return listWargaModel;
  }

  Future createDataWarga(Map data) async{
    await post('/rt/warga/create', data);
  }

  Future updateDataWarga(Map data) async{
    await post('/rt/warga/update', data);
  }

  Future updateStatus(String id) async{
    await get('/rt/warga/update_status/'+id);
  }
}