import 'package:aba/activities/main_activity.dart';
import 'package:aba/constants/Styles.dart';
import 'package:aba/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ABA',
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 53, 20, 158),
            canvasColor: Styles.MyBackgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            unselectedWidgetColor: Colors.white,
            accentColor: Styles.MyLighterAccent),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: MainActivity());
  }
}
