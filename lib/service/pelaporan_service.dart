import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/list_pelaporan_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class PelaporanService extends HttpService {
  Future getPelaporanBelumDiproses(String id) async{
    Response response = await get('/warga/pelaporan/belum_diproses/$id');
    ListPelaporanModel listPelaporanModel = listPelaporanModelFromJson(jsonEncode(response.data));
    return listPelaporanModel;
  }

  Future getPelaporanDiproses(String id) async{
    Response response = await get('/warga/pelaporan/diproses/$id');
    ListPelaporanModel listPelaporanModel = listPelaporanModelFromJson(jsonEncode(response.data));
    return listPelaporanModel;
  }

  Future getPelaporanSelesai(String id) async{
    Response response = await get('/warga/pelaporan/selesai/$id');
    ListPelaporanModel listPelaporanModel = listPelaporanModelFromJson(jsonEncode(response.data));
    return listPelaporanModel;
  }

  Future create(Map data)async{
    await post('/warga/pelaporan/create', data);
  }

  Future postFoto(FormData data)async{
    Response response = await post('/rt/upload-file/pelaporan', data);
    return response.data['results'];
  }
}