import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/service/pelaporan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'pelaporan_state.dart';

@injectable
class PelaporanCubit extends Cubit<PelaporanState> {
  final PelaporanService pelaporanService;
  PelaporanCubit(this.pelaporanService) : super(PelaporanInitial());
  String? id;

  Future init() async {
    try{
      emit(PelaporanLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        // model = await informasiService.getInformasi(id.toString());
      }
      emit(PelaporanLoaded());
    }catch (e){
      emit(PelaporanFailure(e.toString()));
    }
  }

  Future create(Map data, {bool dist=false}) async {
    data['id_rt'] = id;
    final currentState = state;
    if (state is PelaporanLoaded){
      try{
        emit(PelaporanCreating());
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
        emit(PelaporanCreated());
        emit(currentState);
      } catch (e){
        emit(PelaporanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
