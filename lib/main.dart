import 'package:flutter/material.dart';
import 'package:gps_plus/src/pages/first_launch_page.dart';
import 'package:gps_plus/src/pages/login_page.dart';
import 'package:gps_plus/src/styles/text_styles.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS +',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryTextTheme: TextStyles().primaryTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              backgroundColor: Colors.white70,
              textStyle: TextStyles().primaryTextTheme.labelSmall
            )),
        useMaterial3: true,
      ),
      initialRoute: 'launch',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'login':
            return PageTransition(child: LoginPage(), type: PageTransitionType.bottomToTop);
          case 'launch':
            return PageTransition(child: FirstLaunchPage(), type: PageTransitionType.fade);
          default:
            return null;
        }
      },
    );
  }
}
