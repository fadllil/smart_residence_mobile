import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/service/kegiatan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'kegiatan_state.dart';

@injectable
class KegiatanCubit extends Cubit<KegiatanState> {
  final KegiatanService kegiatanService;
  KegiatanCubit(this.kegiatanService) : super(KegiatanInitial());
  ListKegiatanModel? model;
  late List<Result> data;
  String? id;

  Future proses() async {
    try{
      emit(KegiatanLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await kegiatanService.getProses(id.toString());
      }
      emit(KegiatanLoaded());
    }catch (e){
      emit(KegiatanFailure(e.toString()));
    }
  }

  Future selesai() async {
    try{
      emit(KegiatanLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await kegiatanService.getSelesai(id.toString());
      }
      emit(KegiatanLoaded());
    }catch (e){
      emit(KegiatanFailure(e.toString()));
    }
  }

  Future batal() async {
    try{
      emit(KegiatanLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await kegiatanService.getBatal(id.toString());
      }
      emit(KegiatanLoaded());
    }catch (e){
      emit(KegiatanFailure(e.toString()));
    }
  }

  Future postSelesai(String id) async{
    final currentState = state;
    if(state is KegiatanLoaded){
      try{
        emit(KegiatanUpdatingStatus());
        await kegiatanService.postSelesai(id);
        print(id);
        emit(KegiatanUpdatedStatus());
        emit(currentState);
      } catch (e){
        emit(KegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future postBatal(String id) async{
    final currentState = state;
    if(state is KegiatanLoaded){
      try{
        emit(KegiatanUpdatingStatus());
        await kegiatanService.postBatal(id);
        print(id);
        emit(KegiatanUpdatedStatus());
        emit(currentState);
      } catch (e){
        emit(KegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
