import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_residence/config/router.gr.dart';

import 'config/locator.dart';
import 'constants/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: "Smart Mosque",
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          inputDecorationTheme: inputDecorationTheme
      ),
      builder: EasyLoading.init(),
    );
  }
}