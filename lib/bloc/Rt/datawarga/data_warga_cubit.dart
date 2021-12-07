import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/service/warga_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'data_warga_state.dart';

@injectable
class DataWargaCubit extends Cubit<DataWargaState> {
  final WargaService wargaService;
  DataWargaCubit(this.wargaService) : super(DataWargaInitial());
  ListWargaModel? model;
  late List<Result>? data;
  String? id;

  Future init() async{
    try{
      emit(DataWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      print(this.id);
      if(this.id!=null){
        model = await wargaService.getDataWarga(id!);
      }
      emit(DataWargaLoaded());
    }catch (e){
      emit(DataWargaFailure(e.toString()));
    }
  }

  Future tidakAktif() async{
    try{
      emit(DataWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      print(this.id);
      if(this.id!=null){
        model = await wargaService.getDataWargaNonAktif(id!);
      }
      emit(DataWargaLoaded());
    }catch (e){
      emit(DataWargaFailure(e.toString()));
    }
  }

  Future create(Map data) async {
    final currentState = state;
    if (state is DataWargaLoaded){
      try{
        emit(DataWargaCreating());
        data['id_rt'] = id!;
        await wargaService.createDataWarga(data);
        emit(DataWargaCreated());
        emit(currentState);
      }catch (e){
        emit(DataWargaError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future update(Map data) async {
    final currentState = state;
    if (state is DataWargaLoaded){
      try{
        emit(DataWargaUpdating());
        await wargaService.updateDataWarga(data);
        emit(DataWargaUpdated());
        emit(currentState);
      }catch (e){
        emit(DataWargaError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updateStatus(String id) async {
    final currentState = state;
    if (state is DataWargaLoaded){
      try{
        emit(DataWargaUpdating());
        await wargaService.updateStatus(id);
        emit(DataWargaUpdated());
        emit(currentState);
      }catch (e){
        emit(DataWargaError(e.toString()));
        emit(currentState);
      }
    }
  }
}
