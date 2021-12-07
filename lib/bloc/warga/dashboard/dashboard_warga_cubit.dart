import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'dashboard_warga_state.dart';

@injectable
class DashboardWargaCubit extends Cubit<DashboardWargaState> {
  DashboardWargaCubit() : super(DashboardWargaInitial());
  Future init() async{
    try{
      emit(DashboardWargaLoading());
      String nama = await locator<PreferencesHelper>().getValue('nama');
      emit(DashboardWargaLoaded(nama: nama));
    }catch (e){
      emit(DashboardWargaFailure(e.toString()));
    }
  }

  Future changeState() async{
    final currentState = state;
    if(state is DashboardWargaLoaded){
      emit(DashboardWargaLoading());
      print(state);
      await Future.delayed(Duration(seconds: 2));
      emit(currentState);
    }
  }
}
