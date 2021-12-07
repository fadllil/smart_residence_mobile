import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/detail_anggota_model.dart';
import 'package:smart_residence/service/kegiatan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'kegiatan_anggota_state.dart';

@injectable
class KegiatanAnggotaCubit extends Cubit<KegiatanAnggotaState> {
  final KegiatanService kegiatanService;
  KegiatanAnggotaCubit(this.kegiatanService) : super(KegiatanAnggotaInitial());
  DetailAnggotaModel? model;
  late List<DetailAnggota> data;
  String? id;

  Future init(String id) async {
    try{
      emit(KegiatanAnggotaLoading());
      model = await kegiatanService.getDetailAnggota(id.toString());
      emit(KegiatanAnggotaLoaded());
    }catch (e){
      emit(KegiatanAnggotaFailure(e.toString()));
    }
  }
}
