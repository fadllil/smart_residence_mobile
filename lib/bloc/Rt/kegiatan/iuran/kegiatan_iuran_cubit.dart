import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/model/detail_iuran_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/service/kegiatan_service.dart';

part 'kegiatan_iuran_state.dart';

@injectable
class KegiatanIuranCubit extends Cubit<KegiatanIuranState> {
  final HttpService httpService;
  final KegiatanService kegiatanService;
  KegiatanIuranCubit(this.httpService, this.kegiatanService) : super(KegiatanIuranInitial());
  DetailIuranModel? model;
  late List<Result> data;
  String? id;

  Future init(String id) async {
    try{
      emit(KegiatanIuranLoading());
      model = await kegiatanService.getDetailIuranBelumBayar(id.toString());
      emit(KegiatanIuranLoaded());
    }catch (e){
      emit(KegiatanIuranFailure(e.toString()));
    }
  }

  Future menungguValidasi(String id) async {
    try{
      emit(KegiatanIuranLoading());
      model = await kegiatanService.getDetailIuranMenungguValidasi(id.toString());
      emit(KegiatanIuranLoaded());
    }catch (e){
      emit(KegiatanIuranFailure(e.toString()));
    }
  }

  Future sudahBayar(String id) async {
    try{
      emit(KegiatanIuranLoading());
      model = await kegiatanService.getDetailIuranSudahBayar(id.toString());
      emit(KegiatanIuranLoaded());
    }catch (e){
      emit(KegiatanIuranFailure(e.toString()));
    }
  }

  Future validasi(String id) async{
    try{
      emit(KegiatanIuranUpdating());
      await kegiatanService.validasi(id);
      emit(KegiatanIuranUpdated());
    }catch (e){
      emit(KegiatanIuranError(e.toString()));
    }
  }
}
