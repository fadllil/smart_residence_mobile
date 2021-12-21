import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/berpartisipasi_peserta_model.dart';
import 'package:smart_residence/model/detail_anggota_model.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/service/kegiatan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'kegiatan_peserta_state.dart';

@injectable
class KegiatanPesertaCubit extends Cubit<KegiatanPesertaState> {
  final KegiatanService kegiatanService;
  KegiatanPesertaCubit(this.kegiatanService) : super(KegiatanPesertaInitial());
  DetailAnggotaModel? model;
  BerpartisipasiPesertaModel? berpartisipasiPesertaModel;
  String? id_user;
  String? id_rt;

  Future init(int id) async {
    try{
      emit(KegiatanPesertaLoading());
      model = await kegiatanService.getDetailAnggota(id.toString());
      emit(KegiatanPesertaLoaded());
    }catch (e){
      emit(KegiatanPesertaFailure(e.toString()));
    }
  }

  Future berpartisipasi(int id) async {
    try{
      emit(KegiatanPesertaLoading());
      this.id_user = await locator<PreferencesHelper>().getValue('id');
      berpartisipasiPesertaModel = await kegiatanService.berpartisipasiAnggota(id.toString(), id_user!);
      emit(KegiatanPesertaLoaded());
    }catch (e){
      emit(KegiatanPesertaFailure(e.toString()));
    }
  }

  Future join(Map data) async {
    final currentState = state;
    if (state is KegiatanPesertaLoaded){
      try{
        emit(KegiatanPesertaCreating());
        data['id_user'] = this.id_user;
        await kegiatanService.joinPeserta(data);
        emit(KegiatanPesertaCreated());
        emit(currentState);
      } catch (e){
        emit(KegiatanPesertaError(e.toString()));
        emit(currentState);
      }
    }
  }
}
