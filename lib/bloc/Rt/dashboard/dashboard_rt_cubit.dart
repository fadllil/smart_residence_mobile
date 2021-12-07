import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'dashboard_rt_state.dart';

@injectable
class DashboardRtCubit extends Cubit<DashboardRtState> {
  DashboardRtCubit() : super(DashboardRtInitial());
  Future init() async{
    try{
      emit(DashboardRtLoading());
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
