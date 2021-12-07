import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/auth/authentication_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/view/login.dart';
import 'package:smart_residence/view/rt/home_rt.dart';
import 'package:smart_residence/view/warga/home_warga.dart';
import 'package:smart_residence/view/welcome-screen/WelcomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (_)=>locator<AuthenticationCubit>()..appStarted(),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state){
          print(state);
          if(state is AuthenticationUnauthenticated){
            return WelcomeScreen();
          }else if(state is AuthenticationAuthenticated){
            if(state.role == 'RT')
              return HomeRt();
            else if (state.role == 'Warga')
              return HomeWarga();
            else{
              EasyLoading.showError('Kredensial anda tidak valid',duration: Duration(seconds: 2));
              return Login();
            }
          }else if(state is AuthenticationInitial||state is AuthenticationLoading){
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }else{
            return Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }
        },
      ),
    );
  }
}