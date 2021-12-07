import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_informasi_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/service/informasi_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'informasi_warga_state.dart';

@injectable
class InformasiWargaCubit extends Cubit<InformasiWargaState> {
  final InformasiService informasiService;
  final HttpService httpService;
  InformasiWargaCubit(this.informasiService, this.httpService) : super(InformasiWargaInitial());

  ListInformasiModel? model;
  late List<Result> data;
  String? id;

  Future init() async {
    try{
      emit(InformasiWargaLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await informasiService.getInformasi(id.toString());
      }
      emit(InformasiWargaLoaded());
    }catch (e){
      emit(InformasiWargaFailure(e.toString()));
    }
  }
}
