import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_informasi_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/service/informasi_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'informasi_state.dart';

@injectable
class InformasiCubit extends Cubit<InformasiState> {
  final InformasiService informasiService;
  final HttpService httpService;
  InformasiCubit(this.informasiService, this.httpService) : super(InformasiInitial());
  ListInformasiModel? model;
  late List<Result> data;
  String? id;

  Future init() async {
    try{
      emit(InformasiLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await informasiService.getInformasi(id.toString());
      }
      emit(InformasiLoaded());
    }catch (e){
      emit(InformasiFailure(e.toString()));
    }
  }

  Future createInformasi(Map data) async {
    data['id_rt'] = id;
    final currentState = state;
    if (state is InformasiLoaded){
      try{
        emit(InformasiCreating());
        List<MapEntry<String, MultipartFile>> listFoto = [];
        File file = File(data['foto']);
        String fileName = file.path.split('/').last;
        listFoto.add(MapEntry(
            "file", MultipartFile.fromFileSync(file.path, filename: fileName)));
        FormData formData = FormData();
        formData.files.addAll(listFoto);
        String foto = await informasiService.postFoto(formData);
        data..addAll({"gambar": foto});
        await informasiService.createInformasi(data);
        emit(InformasiCreated());
        emit(currentState);
      } catch (e){
        emit(InformasiError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updateInformasi(Map data) async {
    final currentState = state;
    if (state is InformasiLoaded){
      try{
        emit(InformasiUpdating());
        await informasiService.updateInformasi(data);
        emit(InformasiUpdated());
        emit(currentState);
      } catch (e){
        emit(InformasiError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deleteInformasi(String _id) async {
    final currentState = state;
    if (state is InformasiLoaded){
      try{
        emit(InformasiDeleting());
        await informasiService.deleteInformasi(_id);
        emit(InformasiDeleted());
        emit(currentState);
      }catch (e){
        emit(InformasiError(e.toString()));
        emit(currentState);
      }
    }
  }
}
