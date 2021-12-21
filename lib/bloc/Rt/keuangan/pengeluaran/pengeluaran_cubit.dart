import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/keuangan_model.dart';
import 'package:smart_residence/model/list_data_kegiatan_model.dart';
import 'package:smart_residence/model/list_pengeluaran_model.dart';
import 'package:smart_residence/service/kegiatan_service.dart';
import 'package:smart_residence/service/keuangan_service.dart';
import 'package:smart_residence/service/pengeluaran_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'pengeluaran_state.dart';

@injectable
class PengeluaranCubit extends Cubit<PengeluaranState> {
  final KegiatanService kegiatanService;
  final PengeluaranService pengeluaranService;
  final KeuanganService keuanganService;
  PengeluaranCubit(this.kegiatanService, this.pengeluaranService, this.keuanganService) : super(PengeluaranInitial());
  ListDataKegiatanModel? listDataKegiatanModel;
  ListPengeluaranModel? model;
  KeuanganModel? keuanganModel;
  String? id;
  String? id_rt;

  Future init() async {
    try{
      emit(PengeluaranLoading());
      this.id_rt = await locator<PreferencesHelper>().getValue('id_rt');
      if(this.id_rt!=null){
        model = await pengeluaranService.getPengeluaran(id_rt.toString());
        keuanganModel = await keuanganService.getKeuangan(id_rt.toString());
      }
      await Future.wait([getKegiatan()]);
      emit(PengeluaranLoaded(listDataKegiatanModel : listDataKegiatanModel));
    }catch (e){
      emit(PengeluaranFailure(e.toString()));
    }
  }

  Future getKegiatan() async {
    listDataKegiatanModel = await kegiatanService.getKegiatan(id_rt!);
  }

  Future createPengeluaran(Map data) async{
    final currentState = state;
    if(state is PengeluaranLoaded){
      try{
        emit(PengeluaranCreating());
        data['id_rt'] = id_rt;
        await pengeluaranService.createPengeluaran(data);
        emit(PengeluaranCreated());
        emit(currentState);
      } catch (e){
        emit(PengeluaranError(e.toString()));
        emit(currentState);
      }
    }
  }
}
