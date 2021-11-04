// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../view/home.dart' as _i5;
import '../view/login.dart' as _i7;
import '../view/profil.dart' as _i8;
import '../view/rt/home_rt.dart' as _i6;
import '../view/splash_screen.dart' as _i3;
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
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args =
              data.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
          return _i5.Home(key: args.key, index: args.index);
        }),
    HomeRtRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<HomeRtRouteArgs>(
              orElse: () => const HomeRtRouteArgs());
          return _i6.HomeRt(key: args.key, index: args.index);
        }),
    LoginRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.Login();
        }),
    ProfileRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i8.Profile();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(WelcomeScreenRoute.name, path: '/welcome-screen'),
        _i1.RouteConfig(HomeRoute.name, path: '/home'),
        _i1.RouteConfig(HomeRtRoute.name, path: '/home-rt'),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(ProfileRoute.name, path: '/profil')
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

class HomeRoute extends _i1.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i2.Key? key, int? index})
      : super(name, path: '/home', args: HomeRouteArgs(key: key, index: index));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.index});

  final _i2.Key? key;

  final int? index;
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

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute() : super(name, path: '/profil');

  static const String name = 'ProfileRoute';
}
