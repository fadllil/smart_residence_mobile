import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/bloc/auth/authentication_cubit.dart';
import 'package:smart_residence/service/login_service.dart';

part 'login_state.dart';
@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginService loginService;
  final AuthenticationCubit authenticationCubit;
  LoginCubit(this.loginService, this.authenticationCubit) : super(LoginInitial());
  Future login(String username, String password)async{
    try{
      emit(LoginLoading());
      await loginService.login(username, password);
      emit(LoginSuccess());
      await authenticationCubit.appStarted();
    }catch(e){
      emit(LoginFailure(message: e.toString()));
    }
  }
}
