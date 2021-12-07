import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_pelaporan_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/service/pelaporan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'pelaporan_warga_state.dart';

@injectable
class PelaporanWargaCubit extends Cubit<PelaporanWargaState> {
  final PelaporanService pelaporanService;
  final HttpService httpService;
  PelaporanWargaCubit(this.pelaporanService, this.httpService) : super(PelaporanWargaInitial());
  ListPelaporanModel? model;
  late List<Result> data;
  String? id;
  String? id_rt;

  Future init() async {
    try{
      emit(PelaporanWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await pelaporanService.getPelaporanBelumDiproses(id.toString());
      }
      emit(PelaporanWargaLoaded());
    }catch (e){
      emit(PelaporanWargaFailure(e.toString()));
    }
  }

  Future diproses() async {
    try{
      emit(PelaporanWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await pelaporanService.getPelaporanDiproses(id.toString());
      }
      emit(PelaporanWargaLoaded());
    }catch (e){
      emit(PelaporanWargaFailure(e.toString()));
    }
  }

  Future selesai() async {
    try{
      emit(PelaporanWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await pelaporanService.getPelaporanSelesai(id.toString());
      }
      emit(PelaporanWargaLoaded());
    }catch (e){
      emit(PelaporanWargaFailure(e.toString()));
    }
  }

  Future create(Map data, {bool dist=false}) async {
    data['id_user'] = id;
    data['id_rt'] = id_rt;
    final currentState = state;
    if (state is PelaporanWargaLoaded){
      try{
        emit(PelaporanWargaCreating());
        List<MapEntry<String, MultipartFile>> listFoto = [];
        File file = File(data['foto']);
        String fileName = file.path.split('/').last;
        listFoto.add(MapEntry(
            "file", MultipartFile.fromFileSync(file.path, filename: fileName)));
        FormData formData = FormData();
        formData.files.addAll(listFoto);
        String foto = await pelaporanService.postFoto(formData);
        data..addAll({"gambar": foto});
        await pelaporanService.create(data);
        emit(PelaporanWargaCreated());
        emit(currentState);
      } catch (e){
        emit(PelaporanWargaError(e.toString()));
        emit(currentState);
      }
    }
  }
}
