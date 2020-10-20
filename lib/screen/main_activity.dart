import 'package:aba/generated/i18n.dart';
import 'package:aba/repository/alarm_repository.dart';
import 'package:aba/view/AlarmList.dart';
import 'package:aba/view/NewAlarmWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmChangeNotifierProvider =
    ChangeNotifierProvider<AlarmChangeNotifier>((ref) {
  return AlarmChangeNotifier();
});

class MainActivity extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ABA: A Better Alarm"),
        ),
        body: AlarmList(),
        floatingActionButton: NewAlarmWidget());
  }
}
