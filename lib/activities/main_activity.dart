import 'package:aba/generated/i18n.dart';
import 'package:aba/views/AlarmList.dart';
import 'package:flutter/material.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitleLong),
      ),
      body: AlarmList(),
    );
  }
}
