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

part 'pelaporan_state.dart';

@injectable
class PelaporanCubit extends Cubit<PelaporanState> {
  final PelaporanService pelaporanService;
  final HttpService httpService;
  PelaporanCubit(this.pelaporanService, this.httpService) : super(PelaporanInitial());
  ListPelaporanModel? model;
  late List<Result> data;
  String? id;
  String? id_rt;

  Future init(String status) async {
    try{
      emit(PelaporanLoading());
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id_rt!=null){
        model = await pelaporanService.getPelaporan(id_rt.toString(), status);
      }
      emit(PelaporanLoaded());
    }catch (e){
      emit(PelaporanFailure(e.toString()));
    }
  }

  Future prosesPelaporan(String id, String status) async{
    try{
      emit(PelaporanUpdating());
      await pelaporanService.proses(id, status);
      emit(PelaporanUpdated());
    }catch (e){
      emit(PelaporanError(e.toString()));
    }
  }
}
