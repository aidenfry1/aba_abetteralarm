import 'package:aba/constants/Styles.dart';
import 'package:aba/screen/main_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
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
        home: MainActivity());
  }
}
