import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/profil_warga_model.dart';
import 'package:smart_residence/service/profil_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'profil_warga_state.dart';

@injectable
class ProfilWargaCubit extends Cubit<ProfilWargaState> {
  final ProfilService profilService;
  ProfilWargaCubit(this.profilService) : super(ProfilWargaInitial());
  ProfilWargaModel? model;
  String? id;

  Future init() async {
    try{
      emit(ProfilWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      if(this.id!=null){
        model = await profilService.getProfilWarga(id.toString());
      }
      emit(ProfilWargaLoaded());
    }catch (e){
      emit(ProfilWargaFailure(e.toString()));
    }
  }

  Future update(Map data) async{
    try{
      emit(ProfilWargaUpdating());
      await profilService.updateProfil(data);
      await locator<PreferencesHelper>().storeValueString('nama', data['nama']);
      emit(ProfilWargaUpdated());
      await init();
    }catch (e){
      emit(ProfilWargaError(e.toString()));
    }
  }
}
