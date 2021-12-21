// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../model/list_warga_model.dart' as _i23;
import '../view/components/option_with_search.dart' as _i20;
import '../view/login.dart' as _i6;
import '../view/rt/home_rt.dart' as _i5;
import '../view/rt/informasi/informasi.dart' as _i14;
import '../view/rt/jenis_surat/jenis_surat.dart' as _i22;
import '../view/rt/kegiatan/detail/anggota.dart' as _i11;
import '../view/rt/kegiatan/detail/iuran.dart' as _i12;
import '../view/rt/kegiatan/kegiatan.dart' as _i9;
import '../view/rt/kegiatan/tambah_kegiatan.dart' as _i19;
import '../view/rt/keuangan/keuangan.dart' as _i18;
import '../view/rt/pelaporan/pelaporan.dart' as _i15;
import '../view/rt/surat/surat.dart' as _i17;
import '../view/rt/warga/detail_warga.dart' as _i8;
import '../view/rt/warga/warga.dart' as _i7;
import '../view/splash_screen.dart' as _i3;
import '../view/warga/kegiatan/detail/iuran_warga.dart' as _i13;
import '../view/warga/kegiatan/detail/kegiatan_peserta.dart' as _i10;
import '../view/warga/pelaporan/pelaporan_warga.dart' as _i16;
import '../view/warga/surat/surat_warga.dart' as _i21;
import '../view/welcome-screen/WelcomeScreen.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.SplashScreen();
        }),
    WelcomeScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.WelcomeScreen();
        }),
    HomeRtRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<HomeRtRouteArgs>(
              orElse: () => const HomeRtRouteArgs());
          return _i5.HomeRt(key: args.key, index: args.index);
        }),
    LoginRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.Login();
        }),
    WargaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.Warga();
        }),
    DetailWargaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DetailWargaRouteArgs>();
          return _i8.DetailWarga(
              key: args.key, model: args.model, index: args.index);
        }),
    KegiatanRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i9.Kegiatan();
        }),
    KegiatanPesertaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<KegiatanPesertaRouteArgs>();
          return _i10.KegiatanPeserta(key: args.key, id: args.id);
        }),
    AnggotaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AnggotaRouteArgs>();
          return _i11.Anggota(key: args.key, id: args.id);
        }),
    IuranRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<IuranRouteArgs>();
          return _i12.Iuran(key: args.key, id: args.id);
        }),
    IuranWargaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<IuranWargaRouteArgs>();
          return _i13.IuranWarga(key: args.key, id: args.id);
        }),
    InformasiRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i14.Informasi();
        }),
    PelaporanRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i15.Pelaporan();
        }),
    PelaporanWargaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i16.PelaporanWarga();
        }),
    SuratRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i17.Surat();
        }),
    KeuanganRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i18.Keuangan();
        }),
    TambahKegiatanRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i19.TambahKegiatan();
        }),
    CustomOptionWithSearchRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<CustomOptionWithSearchRouteArgs>();
          return _i20.CustomOptionWithSearch(
              key: args.key, options: args.options, title: args.title);
        }),
    SuratWargaRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i21.SuratWarga();
        }),
    JenisSuratRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i22.JenisSurat();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(WelcomeScreenRoute.name, path: '/welcome-screen'),
        _i1.RouteConfig(HomeRtRoute.name, path: '/home-rt'),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(WargaRoute.name, path: '/warga'),
        _i1.RouteConfig(DetailWargaRoute.name, path: '/detail_warga'),
        _i1.RouteConfig(KegiatanRoute.name, path: '/kegiatan'),
        _i1.RouteConfig(KegiatanPesertaRoute.name, path: '/kegiatan_peserta'),
        _i1.RouteConfig(AnggotaRoute.name, path: '/anggota'),
        _i1.RouteConfig(IuranRoute.name, path: '/iuran'),
        _i1.RouteConfig(IuranWargaRoute.name, path: '/iuran_warga'),
        _i1.RouteConfig(InformasiRoute.name, path: '/informasi'),
        _i1.RouteConfig(PelaporanRoute.name, path: '/pelaporan'),
        _i1.RouteConfig(PelaporanWargaRoute.name, path: '/pelaporan_warga'),
        _i1.RouteConfig(SuratRoute.name, path: '/surat'),
        _i1.RouteConfig(KeuanganRoute.name, path: '/keuangan'),
        _i1.RouteConfig(TambahKegiatanRoute.name, path: '/tambah_kegiatan'),
        _i1.RouteConfig(CustomOptionWithSearchRoute.name,
            path: '/custom-option'),
        _i1.RouteConfig(SuratWargaRoute.name, path: '/surat_warga'),
        _i1.RouteConfig(JenisSuratRoute.name, path: '/jenis_surat')
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class WelcomeScreenRoute extends _i1.PageRouteInfo {
  const WelcomeScreenRoute() : super(name, path: '/welcome-screen');

  static const String name = 'WelcomeScreenRoute';
}

class HomeRtRoute extends _i1.PageRouteInfo<HomeRtRouteArgs> {
  HomeRtRoute({_i2.Key? key, int? index})
      : super(name,
            path: '/home-rt', args: HomeRtRouteArgs(key: key, index: index));

  static const String name = 'HomeRtRoute';
}

class HomeRtRouteArgs {
  const HomeRtRouteArgs({this.key, this.index});

  final _i2.Key? key;

  final int? index;
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

class WargaRoute extends _i1.PageRouteInfo {
  const WargaRoute() : super(name, path: '/warga');

  static const String name = 'WargaRoute';
}

class DetailWargaRoute extends _i1.PageRouteInfo<DetailWargaRouteArgs> {
  DetailWargaRoute(
      {_i2.Key? key, required _i23.ListWargaModel? model, required int index})
      : super(name,
            path: '/detail_warga',
            args: DetailWargaRouteArgs(key: key, model: model, index: index));

  static const String name = 'DetailWargaRoute';
}

class DetailWargaRouteArgs {
  const DetailWargaRouteArgs(
      {this.key, required this.model, required this.index});

  final _i2.Key? key;

  final _i23.ListWargaModel? model;

  final int index;
}

class KegiatanRoute extends _i1.PageRouteInfo {
  const KegiatanRoute() : super(name, path: '/kegiatan');

  static const String name = 'KegiatanRoute';
}

class KegiatanPesertaRoute extends _i1.PageRouteInfo<KegiatanPesertaRouteArgs> {
  KegiatanPesertaRoute({_i2.Key? key, required int id})
      : super(name,
            path: '/kegiatan_peserta',
            args: KegiatanPesertaRouteArgs(key: key, id: id));

  static const String name = 'KegiatanPesertaRoute';
}

class KegiatanPesertaRouteArgs {
  const KegiatanPesertaRouteArgs({this.key, required this.id});

  final _i2.Key? key;

  final int id;
}

class AnggotaRoute extends _i1.PageRouteInfo<AnggotaRouteArgs> {
  AnggotaRoute({_i2.Key? key, required int id})
      : super(name, path: '/anggota', args: AnggotaRouteArgs(key: key, id: id));

  static const String name = 'AnggotaRoute';
}

class AnggotaRouteArgs {
  const AnggotaRouteArgs({this.key, required this.id});

  final _i2.Key? key;

  final int id;
}

class IuranRoute extends _i1.PageRouteInfo<IuranRouteArgs> {
  IuranRoute({_i2.Key? key, required int id})
      : super(name, path: '/iuran', args: IuranRouteArgs(key: key, id: id));

  static const String name = 'IuranRoute';
}

class IuranRouteArgs {
  const IuranRouteArgs({this.key, required this.id});

  final _i2.Key? key;

  final int id;
}

class IuranWargaRoute extends _i1.PageRouteInfo<IuranWargaRouteArgs> {
  IuranWargaRoute({_i2.Key? key, required int id})
      : super(name,
            path: '/iuran_warga', args: IuranWargaRouteArgs(key: key, id: id));

  static const String name = 'IuranWargaRoute';
}

class IuranWargaRouteArgs {
  const IuranWargaRouteArgs({this.key, required this.id});

  final _i2.Key? key;

  final int id;
}

class InformasiRoute extends _i1.PageRouteInfo {
  const InformasiRoute() : super(name, path: '/informasi');

  static const String name = 'InformasiRoute';
}

class PelaporanRoute extends _i1.PageRouteInfo {
  const PelaporanRoute() : super(name, path: '/pelaporan');

  static const String name = 'PelaporanRoute';
}

class PelaporanWargaRoute extends _i1.PageRouteInfo {
  const PelaporanWargaRoute() : super(name, path: '/pelaporan_warga');

  static const String name = 'PelaporanWargaRoute';
}

class SuratRoute extends _i1.PageRouteInfo {
  const SuratRoute() : super(name, path: '/surat');

  static const String name = 'SuratRoute';
}

class KeuanganRoute extends _i1.PageRouteInfo {
  const KeuanganRoute() : super(name, path: '/keuangan');

  static const String name = 'KeuanganRoute';
}

class TambahKegiatanRoute extends _i1.PageRouteInfo {
  const TambahKegiatanRoute() : super(name, path: '/tambah_kegiatan');

  static const String name = 'TambahKegiatanRoute';
}

class CustomOptionWithSearchRoute
    extends _i1.PageRouteInfo<CustomOptionWithSearchRouteArgs> {
  CustomOptionWithSearchRoute(
      {_i2.Key? key, required List<dynamic> options, required String title})
      : super(name,
            path: '/custom-option',
            args: CustomOptionWithSearchRouteArgs(
                key: key, options: options, title: title));

  static const String name = 'CustomOptionWithSearchRoute';
}

class CustomOptionWithSearchRouteArgs {
  const CustomOptionWithSearchRouteArgs(
      {this.key, required this.options, required this.title});

  final _i2.Key? key;

  final List<dynamic> options;

  final String title;
}

class SuratWargaRoute extends _i1.PageRouteInfo {
  const SuratWargaRoute() : super(name, path: '/surat_warga');

  static const String name = 'SuratWargaRoute';
}

class JenisSuratRoute extends _i1.PageRouteInfo {
  const JenisSuratRoute() : super(name, path: '/jenis_surat');

  static const String name = 'JenisSuratRoute';
}
