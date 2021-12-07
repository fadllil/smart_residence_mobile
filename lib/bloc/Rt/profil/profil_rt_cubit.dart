import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/profil_rt_model.dart';
import 'package:smart_residence/service/profil_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'profil_rt_state.dart';

@injectable
class ProfilRtCubit extends Cubit<ProfilRtState> {
  final ProfilService profilService;
  ProfilRtCubit(this.profilService) : super(ProfilRtInitial());
  late ProfilRtModel profilRtModel;
  String? id;

  Future init() async {
    try{
      emit(ProfilRtLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      profilRtModel = await profilService.getProfil(id!);
      emit(ProfilRtLoaded());
    }catch (e){
      // print(profilModel);
      emit(ProfilRtFailure(e.toString()));
    }
  }

  Future update(Map data) async{
    try{
      emit(ProfilRtUpdating());
      await profilService.updateProfil(data);
      await locator<PreferencesHelper>().storeValueString('nama', data['nama']);
      emit(ProfilRtUpdated());
      await init();
    }catch (e){
      emit(ProfilRtError(e.toString()));
    }
  }
}
