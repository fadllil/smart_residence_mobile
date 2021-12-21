import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/jenis_surat_model.dart';
import 'package:smart_residence/service/jenis_surat_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'jenis_surat_state.dart';

@injectable
class JenisSuratCubit extends Cubit<JenisSuratState> {
  final JenisSuratService jenisSuratService;
  JenisSuratCubit(this.jenisSuratService) : super(JenisSuratInitial());
  JenisSuratModel? model;
  late List<Result>? data;
  String? id;

  Future init() async {
    try{
      emit(JenisSuratLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await jenisSuratService.getSurat(id.toString());
      }
      emit(JenisSuratLoaded());
    }catch (e){
      emit(JenisSuratFailure(e.toString()));
    }
  }

  Future create(Map data) async {
    final currentState = state;
    if (state is JenisSuratLoaded){
      try{
        emit(JenisSuratCreating());
        data['id_rt'] = id!;
        await jenisSuratService.create(data);
        emit(JenisSuratCreated());
        emit(currentState);
      }catch (e){
        emit(JenisSuratError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future update(Map data) async {
    final currentState = state;
    if (state is JenisSuratLoaded){
      try{
        emit(JenisSuratCreating());
        data['id_rt'] = id!;
        await jenisSuratService.update(data);
        emit(JenisSuratCreated());
        emit(currentState);
      }catch (e){
        emit(JenisSuratError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future delete(String id) async {
    final currentState = state;
    if (state is JenisSuratLoaded){
      try{
        emit(JenisSuratCreating());
        await jenisSuratService.delete(id);
        emit(JenisSuratCreated());
        emit(currentState);
      }catch (e){
        emit(JenisSuratError(e.toString()));
        emit(currentState);
      }
    }
  }
}
