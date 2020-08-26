import 'package:aba/generated/i18n.dart';
import 'package:aba/views/AlarmList.dart';
import 'package:flutter/material.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

//Widget build(BuildContext context) {
//  return MaterialApp(
//    title: 'ABA',
//    theme: ThemeData(
//      primarySwatch: Colors.deepPurple,
//      visualDensity: VisualDensity.adaptivePlatformDensity,
//    ),
//  );
//}

class _MainActivityState extends State<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitleLong),
        backgroundColor: Color(0xff35149E),
      ),
      body: AlarmList(),
      backgroundColor: Color(0xff240E6B),
    );
  }
}
