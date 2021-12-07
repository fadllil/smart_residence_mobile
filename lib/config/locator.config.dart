// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/auth/authentication_cubit.dart' as _i4;
import '../bloc/counter/counter_cubit.dart' as _i5;
import '../bloc/login/login_cubit.dart' as _i28;
import '../bloc/Rt/dashboard/dashboard_rt_cubit.dart' as _i6;
import '../bloc/Rt/datawarga/data_warga_cubit.dart' as _i22;
import '../bloc/Rt/informasi/informasi_cubit.dart' as _i23;
import '../bloc/Rt/kegiatan/anggota/kegiatan_anggota_cubit.dart' as _i25;
import '../bloc/Rt/kegiatan/iuran/kegiatan_iuran_cubit.dart' as _i27;
import '../bloc/Rt/kegiatan/kegiatan_cubit.dart' as _i26;
import '../bloc/Rt/pelaporan/pelaporan_cubit.dart' as _i29;
import '../bloc/Rt/profil/profil_rt_cubit.dart' as _i30;
import '../bloc/Rt/tambah_kegiatan/tambah_kegiatan_cubit.dart' as _i31;
import '../bloc/warga/dashboard/dashboard_warga_cubit.dart' as _i7;
import '../bloc/warga/informasi/informasi_warga_cubit.dart' as _i10;
import '../bloc/warga/kegiatan/iuran/iuran_warga_cubit.dart' as _i24;
import '../bloc/warga/kegiatan/kegiatan_warga_cubit.dart' as _i12;
import '../bloc/warga/pelaporan/pelaporan_warga_cubit.dart' as _i15;
import '../bloc/warga/profil/profil_warga_cubit.dart' as _i18;
import '../bloc/warga/surat/surat_warga_cubit.dart' as _i20;
import '../service/api_interceptor.dart' as _i3;
import '../service/http_service.dart' as _i8;
import '../service/informasi_service.dart' as _i9;
import '../service/kegiatan_service.dart' as _i11;
import '../service/login_service.dart' as _i13;
import '../service/pelaporan_service.dart' as _i14;
import '../service/profil_service.dart' as _i17;
import '../service/surat_service.dart' as _i19;
import '../service/warga_service.dart' as _i21;
import '../utils/preferences_helper.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiInterceptors>(() => _i3.ApiInterceptors());
  gh.factory<_i4.AuthenticationCubit>(() => _i4.AuthenticationCubit());
  gh.factory<_i5.CounterCubit>(() => _i5.CounterCubit());
  gh.factory<_i6.DashboardRtCubit>(() => _i6.DashboardRtCubit());
  gh.factory<_i7.DashboardWargaCubit>(() => _i7.DashboardWargaCubit());
  gh.lazySingleton<_i8.HttpService>(() => _i8.HttpService());
  gh.lazySingleton<_i9.InformasiService>(() => _i9.InformasiService());
  gh.factory<_i10.InformasiWargaCubit>(() => _i10.InformasiWargaCubit(
      get<_i9.InformasiService>(), get<_i8.HttpService>()));
  gh.lazySingleton<_i11.KegiatanService>(() => _i11.KegiatanService());
  gh.factory<_i12.KegiatanWargaCubit>(
      () => _i12.KegiatanWargaCubit(get<_i11.KegiatanService>()));
  gh.lazySingleton<_i13.LoginService>(() => _i13.LoginService());
  gh.lazySingleton<_i14.PelaporanService>(() => _i14.PelaporanService());
  gh.factory<_i15.PelaporanWargaCubit>(() => _i15.PelaporanWargaCubit(
      get<_i14.PelaporanService>(), get<_i8.HttpService>()));
  gh.lazySingleton<_i16.PreferencesHelper>(() => _i16.PreferencesHelper());
  gh.lazySingleton<_i17.ProfilService>(() => _i17.ProfilService());
  gh.factory<_i18.ProfilWargaCubit>(
      () => _i18.ProfilWargaCubit(get<_i17.ProfilService>()));
  gh.lazySingleton<_i19.SuratService>(() => _i19.SuratService());
  gh.factory<_i20.SuratWargaCubit>(() =>
      _i20.SuratWargaCubit(get<_i19.SuratService>(), get<_i8.HttpService>()));
  gh.lazySingleton<_i21.WargaService>(() => _i21.WargaService());
  gh.factory<_i22.DataWargaCubit>(
      () => _i22.DataWargaCubit(get<_i21.WargaService>()));
  gh.factory<_i23.InformasiCubit>(() =>
      _i23.InformasiCubit(get<_i9.InformasiService>(), get<_i8.HttpService>()));
  gh.factory<_i24.IuranWargaCubit>(
      () => _i24.IuranWargaCubit(get<_i11.KegiatanService>()));
  gh.factory<_i25.KegiatanAnggotaCubit>(
      () => _i25.KegiatanAnggotaCubit(get<_i11.KegiatanService>()));
  gh.factory<_i26.KegiatanCubit>(
      () => _i26.KegiatanCubit(get<_i11.KegiatanService>()));
  gh.factory<_i27.KegiatanIuranCubit>(
      () => _i27.KegiatanIuranCubit(get<_i11.KegiatanService>()));
  gh.factory<_i28.LoginCubit>(() => _i28.LoginCubit(
      get<_i13.LoginService>(), get<_i4.AuthenticationCubit>()));
  gh.factory<_i29.PelaporanCubit>(
      () => _i29.PelaporanCubit(get<_i14.PelaporanService>()));
  gh.factory<_i30.ProfilRtCubit>(
      () => _i30.ProfilRtCubit(get<_i17.ProfilService>()));
  gh.factory<_i31.TambahKegiatanCubit>(() => _i31.TambahKegiatanCubit(
      get<_i11.KegiatanService>(), get<_i21.WargaService>()));
  return get;
}
