import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_surat_model.dart';
import 'package:smart_residence/service/surat_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'surat_state.dart';

@injectable
class SuratCubit extends Cubit<SuratState> {
  final SuratService suratService;
  SuratCubit(this.suratService) : super(SuratInitial());
  ListSuratModel? model;
  String? id_rt;

  Future getSurat(String status) async {
    try{
      emit(SuratLoading());
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id_rt!=null){
        model = await suratService.getSurat(id_rt.toString(), status);
      }
      emit(SuratLoaded());
    }catch (e){
      emit(SuratFailure(e.toString()));
    }
  }
}
