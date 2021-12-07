import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/service/kegiatan_service.dart';
import 'package:smart_residence/service/warga_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'tambah_kegiatan_state.dart';

@injectable
class TambahKegiatanCubit extends Cubit<TambahKegiatanState> {
  final KegiatanService kegiatanService;
  final WargaService wargaService;
  TambahKegiatanCubit(this.kegiatanService, this.wargaService) : super(TambahKegiatanInitial());
  ListWargaModel? warga;
  String? id;

  Future init() async {
    try{
      emit(TambahKegiatanLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      await Future.wait([getWarga()]);
      emit(TambahKegiatanLoaded(warga:warga));
    }catch (e){
      emit(TambahKegiatanFailure(e.toString()));
    }
  }

  Future getWarga() async {
    warga = await wargaService.getDataWarga(id!);
  }

  Future create(Map data) async{
    final currentState = state;
    if(state is TambahKegiatanLoaded){
      try{
        emit(TambahKegiatanCreating());
        data['id_rt'] = id;
        await kegiatanService.createKegiatan(data);
        print(id);
        emit(TambahKegiatanCreated());
        emit(currentState);
      } catch (e){
        emit(TambahKegiatanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
