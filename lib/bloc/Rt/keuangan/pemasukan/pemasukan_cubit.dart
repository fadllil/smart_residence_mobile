import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/keuangan_model.dart';
import 'package:smart_residence/model/list_pemasukan_model.dart';
import 'package:smart_residence/service/keuangan_service.dart';
import 'package:smart_residence/service/pemasukan_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'pemasukan_state.dart';

@injectable
class PemasukanCubit extends Cubit<PemasukanState> {
  final PemasukanService pemasukanService;
  final KeuanganService keuanganService;
  PemasukanCubit(this.pemasukanService, this.keuanganService) : super(PemasukanInitial());
  ListPemasukanModel? model;
  KeuanganModel? keuanganModel;
  late List<Result> data;
  String? id;

  Future init() async {
    try{
      emit(PemasukanLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id!=null){
        model = await pemasukanService.getPemasukan(id.toString());
        keuanganModel = await keuanganService.getKeuangan(id.toString());
      }
      emit(PemasukanLoaded());
    }catch (e){
      emit(PemasukanFailure(e.toString()));
    }
  }
}
