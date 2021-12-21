import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/detail_iuran_warga_model.dart';
import 'package:smart_residence/service/kegiatan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'iuran_warga_state.dart';

@injectable
class IuranWargaCubit extends Cubit<IuranWargaState> {
  final KegiatanService kegiatanService;
  IuranWargaCubit(this.kegiatanService) : super(IuranWargaInitial());
  DetailIuranWargaModel? model;
  String? id;
  String? id_user;

  Future init(String id) async {
    try{
      emit(IuranWargaLoading());
      this.id_user = await locator<PreferencesHelper>().getValue('id');
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      model = await kegiatanService.getDetailIuranWarga(id, id_user!);
      emit(IuranWargaLoaded());
    }catch (e){
      emit(IuranWargaFailure(e.toString()));
    }
  }

  Future bayar(Map data, String status) async{
    final currentState = state;
    if (state is IuranWargaLoaded){
      try{
        emit(IuranWargaUpdating());
        List<MapEntry<String, MultipartFile>> listFoto = [];
        File file = File(data['foto']);
        String fileName = file.path.split('/').last;
        listFoto.add(MapEntry(
            "file", MultipartFile.fromFileSync(file.path, filename: fileName)));
        FormData formData = FormData();
        formData.files.addAll(listFoto);
        String foto = await kegiatanService.postFoto(formData);
        data..addAll({"gambar": foto});
        if (status == 'Wajib'){
          await kegiatanService.bayar(data);
        }else{
          data['id_user'] = id_user;
          await kegiatanService.bayarDonasi(data);
        }
        emit(IuranWargaUpdated());
        emit(currentState);
      } catch (e){
        emit(IuranWargaError(e.toString()));
        emit(currentState);
      }
    }
  }
}
