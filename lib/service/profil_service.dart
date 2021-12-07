import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/profil_rt_model.dart';
import 'package:smart_residence/model/profil_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';

@lazySingleton
class ProfilService extends HttpService{
  Future getProfil(String id) async{
    Response response = await get('/rt/profil/$id');
    ProfilRtModel profilRtModel = profilRtModelFromJson(jsonEncode(response.data));
    return profilRtModel;
  }

  Future updateProfil(Map data)async{
    await post('/rt/profil/update', data);
  }

  Future getProfilWarga(String id) async{
    Response response = await get('/warga/profil/$id');
    ProfilWargaModel profilWargaModel = profilWargaModelFromJson(jsonEncode(response.data));
    return profilWargaModel;
  }
}