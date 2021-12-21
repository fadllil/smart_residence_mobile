// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../bloc/auth/authentication_cubit.dart' as _i4;
import '../bloc/counter/counter_cubit.dart' as _i5;
import '../bloc/login/login_cubit.dart' as _i34;
import '../bloc/Rt/dashboard/dashboard_rt_cubit.dart' as _i25;
import '../bloc/Rt/datawarga/data_warga_cubit.dart' as _i26;
import '../bloc/Rt/informasi/informasi_cubit.dart' as _i27;
import '../bloc/Rt/jenis_surat/jenis_surat_cubit.dart' as _i29;
import '../bloc/Rt/kegiatan/anggota/kegiatan_anggota_cubit.dart' as _i30;
import '../bloc/Rt/kegiatan/iuran/kegiatan_iuran_cubit.dart' as _i32;
import '../bloc/Rt/kegiatan/kegiatan_cubit.dart' as _i31;
import '../bloc/Rt/keuangan/pemasukan/pemasukan_cubit.dart' as _i36;
import '../bloc/Rt/keuangan/pengeluaran/pengeluaran_cubit.dart' as _i37;
import '../bloc/Rt/pelaporan/pelaporan_cubit.dart' as _i35;
import '../bloc/Rt/profil/profil_rt_cubit.dart' as _i38;
import '../bloc/Rt/surat/surat_cubit.dart' as _i39;
import '../bloc/Rt/tambah_kegiatan/tambah_kegiatan_cubit.dart' as _i40;
import '../bloc/warga/dashboard/dashboard_warga_cubit.dart' as _i6;
import '../bloc/warga/informasi/informasi_warga_cubit.dart' as _i9;
import '../bloc/warga/kegiatan/iuran/iuran_warga_cubit.dart' as _i28;
import '../bloc/warga/kegiatan/kegiatan_warga_cubit.dart' as _i12;
import '../bloc/warga/kegiatan/peserta/kegiatan_peserta_cubit.dart' as _i33;
import '../bloc/warga/pelaporan/pelaporan_warga_cubit.dart' as _i16;
import '../bloc/warga/profil/profil_warga_cubit.dart' as _i21;
import '../bloc/warga/surat/surat_warga_cubit.dart' as _i23;
import '../service/api_interceptor.dart' as _i3;
import '../service/http_service.dart' as _i7;
import '../service/informasi_service.dart' as _i8;
import '../service/jenis_surat_service.dart' as _i10;
import '../service/kegiatan_service.dart' as _i11;
import '../service/keuangan_service.dart' as _i13;
import '../service/login_service.dart' as _i14;
import '../service/pelaporan_service.dart' as _i15;
import '../service/pemasukan_service.dart' as _i17;
import '../service/pengeluaran_service.dart' as _i18;
import '../service/profil_service.dart' as _i20;
import '../service/surat_service.dart' as _i22;
import '../service/warga_service.dart' as _i24;
import '../utils/preferences_helper.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiInterceptors>(() => _i3.ApiInterceptors());
  gh.factory<_i4.AuthenticationCubit>(() => _i4.AuthenticationCubit());
  gh.factory<_i5.CounterCubit>(() => _i5.CounterCubit());
  gh.factory<_i6.DashboardWargaCubit>(() => _i6.DashboardWargaCubit());
  gh.lazySingleton<_i7.HttpService>(() => _i7.HttpService());
  gh.lazySingleton<_i8.InformasiService>(() => _i8.InformasiService());
  gh.factory<_i9.InformasiWargaCubit>(() => _i9.InformasiWargaCubit(
      get<_i8.InformasiService>(), get<_i7.HttpService>()));
  gh.lazySingleton<_i10.JenisSuratService>(() => _i10.JenisSuratService());
  gh.lazySingleton<_i11.KegiatanService>(() => _i11.KegiatanService());
  gh.factory<_i12.KegiatanWargaCubit>(
      () => _i12.KegiatanWargaCubit(get<_i11.KegiatanService>()));
  gh.lazySingleton<_i13.KeuanganService>(() => _i13.KeuanganService());
  gh.lazySingleton<_i14.LoginService>(() => _i14.LoginService());
  gh.lazySingleton<_i15.PelaporanService>(() => _i15.PelaporanService());
  gh.factory<_i16.PelaporanWargaCubit>(() => _i16.PelaporanWargaCubit(
      get<_i15.PelaporanService>(), get<_i7.HttpService>()));
  gh.lazySingleton<_i17.PemasukanService>(() => _i17.PemasukanService());
  gh.lazySingleton<_i18.PengeluaranService>(() => _i18.PengeluaranService());
  gh.lazySingleton<_i19.PreferencesHelper>(() => _i19.PreferencesHelper());
  gh.lazySingleton<_i20.ProfilService>(() => _i20.ProfilService());
  gh.factory<_i21.ProfilWargaCubit>(
      () => _i21.ProfilWargaCubit(get<_i20.ProfilService>()));
  gh.lazySingleton<_i22.SuratService>(() => _i22.SuratService());
  gh.factory<_i23.SuratWargaCubit>(() => _i23.SuratWargaCubit(
      get<_i22.SuratService>(),
      get<_i10.JenisSuratService>(),
      get<_i7.HttpService>()));
  gh.lazySingleton<_i24.WargaService>(() => _i24.WargaService());
  gh.factory<_i25.DashboardRtCubit>(
      () => _i25.DashboardRtCubit(get<_i24.WargaService>()));
  gh.factory<_i26.DataWargaCubit>(
      () => _i26.DataWargaCubit(get<_i24.WargaService>()));
  gh.factory<_i27.InformasiCubit>(() =>
      _i27.InformasiCubit(get<_i8.InformasiService>(), get<_i7.HttpService>()));
  gh.factory<_i28.IuranWargaCubit>(
      () => _i28.IuranWargaCubit(get<_i11.KegiatanService>()));
  gh.factory<_i29.JenisSuratCubit>(
      () => _i29.JenisSuratCubit(get<_i10.JenisSuratService>()));
  gh.factory<_i30.KegiatanAnggotaCubit>(
      () => _i30.KegiatanAnggotaCubit(get<_i11.KegiatanService>()));
  gh.factory<_i31.KegiatanCubit>(
      () => _i31.KegiatanCubit(get<_i11.KegiatanService>()));
  gh.factory<_i32.KegiatanIuranCubit>(() => _i32.KegiatanIuranCubit(
      get<_i7.HttpService>(), get<_i11.KegiatanService>()));
  gh.factory<_i33.KegiatanPesertaCubit>(
      () => _i33.KegiatanPesertaCubit(get<_i11.KegiatanService>()));
  gh.factory<_i34.LoginCubit>(() => _i34.LoginCubit(
      get<_i14.LoginService>(), get<_i4.AuthenticationCubit>()));
  gh.factory<_i35.PelaporanCubit>(() => _i35.PelaporanCubit(
      get<_i15.PelaporanService>(), get<_i7.HttpService>()));
  gh.factory<_i36.PemasukanCubit>(() => _i36.PemasukanCubit(
      get<_i17.PemasukanService>(), get<_i13.KeuanganService>()));
  gh.factory<_i37.PengeluaranCubit>(() => _i37.PengeluaranCubit(
      get<_i11.KegiatanService>(),
      get<_i18.PengeluaranService>(),
      get<_i13.KeuanganService>()));
  gh.factory<_i38.ProfilRtCubit>(
      () => _i38.ProfilRtCubit(get<_i20.ProfilService>()));
  gh.factory<_i39.SuratCubit>(() => _i39.SuratCubit(get<_i22.SuratService>()));
  gh.factory<_i40.TambahKegiatanCubit>(() => _i40.TambahKegiatanCubit(
      get<_i11.KegiatanService>(), get<_i24.WargaService>()));
  return get;
}
