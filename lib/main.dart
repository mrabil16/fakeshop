import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/constant/app_color.dart';
import 'core/constant/theme_provider.dart';
import 'core/helper/network_connection.dart';
import 'locator.dart';
import 'ui/view/splash_screen_view.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          return MultiProvider(
            providers: [
              StreamProvider<NetworkStatus>(
                create: (context) =>
                    NetworkStatusService().networkStatusController.stream,
                initialData: NetworkStatus.Online,
              ),
            ],
            child: MaterialApp(
              title: 'Technical Test',
              theme: ThemeData(
                primaryColor: colorPrimary,
                cardColor: const Color(0xffF4F7FF),
                cardTheme: CardTheme(
                    color: const Color(0xffF4F7FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            width: 1, color: Color(0xffF4F7FF)))),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: const TextTheme(
                    bodyText1: TextStyle(fontSize: 12, color: colorPrimary),
                    bodyText2: TextStyle(fontSize: 12, color: Colors.black)),
                fontFamily: GoogleFonts.poppins().fontFamily,
                scaffoldBackgroundColor: Colors.white,
              ),
              home: SplashScreenView(),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      );
}
