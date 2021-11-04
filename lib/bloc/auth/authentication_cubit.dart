import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/jwt_model.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  Future appStarted()async{
    try{
      emit(AuthenticationLoading());
      String? token = await locator<PreferencesHelper>().getValue('token');
      if(token!=null){
        JwtModel jwtModel = jwtModelFromJson(ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))));
        await locator<PreferencesHelper>().storeValueString('role', jwtModel.sub!.role!);
        emit(AuthenticationAuthenticated(token: token,role: jwtModel.sub?.role));
      }else{
        emit(AuthenticationUnauthenticated());
      }
    }catch(e){
      emit(AuthenticationFailure(message: e.toString()));
    }
  }
  Future logout()async{
    try{
      emit(AuthenticationLoading());
      await locator<PreferencesHelper>().deleteAll();
      emit(AuthenticationUnauthenticated());
    }catch(_){
      emit(AuthenticationFailure(message: 'Terjadi kesalahan, cek koneksi internet anda'));
    }
  }
}
