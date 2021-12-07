import 'package:bloc/bloc.dart';
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
      model = await kegiatanService.getDetailIuranWarga(id, id_user!);
      emit(IuranWargaLoaded());
    }catch (e){
      emit(IuranWargaFailure(e.toString()));
    }
  }
}
