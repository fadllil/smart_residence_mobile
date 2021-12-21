import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/jenis_surat_model.dart';
import 'package:smart_residence/model/list_surat_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/service/jenis_surat_service.dart';
import 'package:smart_residence/service/surat_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'surat_warga_state.dart';

@injectable
class SuratWargaCubit extends Cubit<SuratWargaState> {
  final SuratService suratService;
  final JenisSuratService jenisSuratService;
  final HttpService httpService;
  SuratWargaCubit(this.suratService, this.jenisSuratService, this.httpService) : super(SuratWargaInitial());
  ListSuratWargaModel? model;
  JenisSuratModel? jenisSuratModel;
  String? id;
  String? id_rt;

  Future getPengajuanSurat(String status) async {
    try{
      emit(SuratWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await suratService.getPengajuanSurat(id.toString(), status);
        jenisSuratModel = await jenisSuratService.getSurat(id_rt!);
      }
      emit(SuratWargaLoaded());
    }catch (e){
      emit(SuratWargaFailure(e.toString()));
    }
  }

  Future create(Map data) async{
    final currentState = state;
    if(state is SuratWargaLoaded){
      try{
        emit(SuratWargaCreating());
        data['id_user'] = id;
        data['id_rt'] = id_rt;
        await suratService.createSuratWarga(data);
        print(id);
        emit(SuratWargaCreated());
        emit(currentState);
      } catch (e){
        emit(SuratWargaError(e.toString()));
        emit(currentState);
      }
    }
  }
}
