import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/auth/authentication_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';

class Profile extends StatefulWidget{
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=> locator<AuthenticationCubit>(),
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state){
          if (state is AuthenticationFailure){
            EasyLoading.dismiss();
            EasyLoading.showError(state.message!);
          } else if (state is AuthenticationUnauthenticated){
            EasyLoading.dismiss();
            AutoRouter.of(context).pushAndPopUntil(
                LoginRoute(), predicate: (route) => false);
          } else if (state is AuthenticationLoading) {
            EasyLoading.show(status:  'Loading...',
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: false);
          }
        },
      ),
    );
  }
}