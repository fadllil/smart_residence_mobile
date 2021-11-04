import 'package:auto_route/auto_route.dart';
import 'package:smart_residence/view/home.dart';
import 'package:smart_residence/view/login.dart';
import 'package:smart_residence/view/profil.dart';
import 'package:smart_residence/view/rt/home_rt.dart';
import 'package:smart_residence/view/splash_screen.dart';
import 'package:smart_residence/view/welcome-screen/WelcomeScreen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true,path: '/'),
    AutoRoute(page: WelcomeScreen, path: '/welcome-screen'),
    AutoRoute(page: Home, path: '/home'),
    AutoRoute(page: HomeRt, path: '/home-rt'),
    AutoRoute(page: Login, path: '/login'),
    AutoRoute(page: Profile, path: '/profil'),
  ],
)
class $AppRouter {}