// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/auth/authentication_cubit.dart' as _i4;
import '../bloc/counter/counter_cubit.dart' as _i5;
import '../bloc/login/login_cubit.dart' as _i11;
import '../bloc/Rt/dashboard/dashboard_rt_cubit.dart' as _i6;
import '../bloc/Rt/datawarga/data_warga_cubit.dart' as _i7;
import '../service/api_interceptor.dart' as _i3;
import '../service/http_service.dart' as _i8;
import '../service/login_service.dart' as _i9;
import '../utils/preferences_helper.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiInterceptors>(() => _i3.ApiInterceptors());
  gh.factory<_i4.AuthenticationCubit>(() => _i4.AuthenticationCubit());
  gh.factory<_i5.CounterCubit>(() => _i5.CounterCubit());
  gh.factory<_i6.DashboardRtCubit>(() => _i6.DashboardRtCubit());
  gh.factory<_i7.DataWargaCubit>(() => _i7.DataWargaCubit());
  gh.lazySingleton<_i8.HttpService>(() => _i8.HttpService());
  gh.lazySingleton<_i9.LoginService>(() => _i9.LoginService());
  gh.lazySingleton<_i10.PreferencesHelper>(() => _i10.PreferencesHelper());
  gh.factory<_i11.LoginCubit>(() =>
      _i11.LoginCubit(get<_i9.LoginService>(), get<_i4.AuthenticationCubit>()));
  return get;
}
