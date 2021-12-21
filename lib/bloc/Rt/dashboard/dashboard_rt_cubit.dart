import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/service/warga_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'dashboard_rt_state.dart';

@injectable
class DashboardRtCubit extends Cubit<DashboardRtState> {
  final WargaService wargaService;
  DashboardRtCubit(this.wargaService) : super(DashboardRtInitial());
  ListWargaModel? model;
  late List<Result>? data;
  String? id;
  Future init() async{
    try{
      emit(DashboardRtLoading());
      this.id = await locator<PreferencesHelper>().getValue('id_rt');
      print(this.id);
      if(this.id!=null){
        model = await wargaService.getDataWarga(id!);
      }
      String nama = await locator<PreferencesHelper>().getValue('nama');
      emit(DashboardRtLoaded(nama: nama));
    }catch (e){
      emit(DashboardRtFailure(e.toString()));
    }
  }

  Future changeState() async{
    final currentState = state;
    if(state is DashboardRtLoaded){
      emit(DashboardRtLoading());
      print(state);
      await Future.delayed(Duration(seconds: 2));
      emit(currentState);
    }
  }
}
