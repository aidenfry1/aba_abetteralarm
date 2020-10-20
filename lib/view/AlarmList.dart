import 'dart:collection';

import 'package:aba/constants/Styles.dart';
import 'package:aba/model/Alarm.dart';
import 'package:aba/repository/weekdays_repository.dart';
import 'package:aba/screen/main_activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TextEditingController _editingController = new TextEditingController();

    final alarmChangeNotifier = watch(alarmChangeNotifierProvider);

    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd)
        return Divider(
          color: Color(0xFF4E1EEB),
        );

      final index = i ~/ 2;

      UnmodifiableListView<Alarm> alarms = alarmChangeNotifier.alarms;

      if (index < alarms.length) {
        return new AlarmRow(
            alarm: alarms[index], editingController: _editingController);
      }
      return null;
    });
  }
}

class AlarmRow extends ConsumerWidget {
  final Alarm alarm;
  final TextEditingController editingController;

  AlarmRow({this.alarm, this.editingController});

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final alarmChangeNotifier = watch(alarmChangeNotifierProvider);

    return ExpansionTile(
        title: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        showTimePicker(
                          initialTime: alarm.time,
                          context: context,
                        ).then((value) {
                          final Alarm oldAlarm = alarm;
                          alarm.time = value;
                          alarmChangeNotifier.update(oldAlarm, alarm);
                        });
                      },
                      child: Text(
                        alarm.time.format(context),
                        style: Styles.MyAlarmTextStyle,
                      )),
                  Switch(
                    value: alarm.enabled,
                    onChanged: (value) {
                      final Alarm oldAlarm = alarm;
                      alarm.enabled = value;
                      alarmChangeNotifier.update(oldAlarm, alarm);
                    },
                    inactiveTrackColor: Colors.white30,
//              activeColor: Colors.green,
                  ),
                ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
              ],
            )),
        subtitle: Padding(
            padding: EdgeInsets.all(6),
            child: Wrap(
              spacing: 4,
              alignment: WrapAlignment.spaceBetween,
              children: WeekDays.daysOfTheWeek
                  .map<Widget>((day) => GestureDetector(
                        onTap: () {
                          final Alarm oldAlarm = alarm;
                          alarm.switchStateOfDay(day);
                          alarmChangeNotifier.update(oldAlarm, alarm);
                        },
                        child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Styles.MyLighterAccent,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: alarm.enabled
                                  ? (alarm.isActiveForDay(day)
                                      ? Styles.MyLighterAccent
                                      : Styles.MyBackgroundColor)
                                  : (alarm.isActiveForDay(day)
                                      ? Colors.grey
                                      : Color.fromARGB(255, 36, 14, 107)),
                              child: Center(
                                child: Text(day.shortDay,
                                    style: Styles.MyDaysTextStyle),
                              ),
                            )),
                      ))
                  .toList(),
            )),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Sound", style: Styles.MyDaysTextStyle),
                  Text("Oxygen", style: Styles.MyDaysTextStyle)
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Label", style: Styles.MyDaysTextStyle),
                  GestureDetector(
                      child: Text(alarm.label, style: Styles.MyDaysTextStyle),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Text("Set Label",
                                    style: Styles.MyDaysTextStyle),
                                backgroundColor: Styles.MyBackgroundColor,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(28, 0, 28, 0),
                                    child: new TextField(
                                      onSubmitted: (newValue) {
                                        Navigator.pop(context, newValue);
                                      },
                                      autofocus: true,
                                      controller: editingController,
                                      style: Styles.MyDaysTextStyle,
                                      cursorColor: Styles.MyLighterAccent,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                        onPressed: () =>
                                            editingController.clear(),
                                        icon: Icon(Icons.clear),
                                        color: Colors.white,
                                      )),
                                    ),
                                  )
                                ],
                              );
                            }).then((value) {
                          Alarm oldAlarm = alarm;
                          alarm.label = value;
                          alarmChangeNotifier.update(oldAlarm, alarm);
                        });
                      })
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Delete", style: Styles.MyDaysTextStyle),
                  Text("Skip ", style: Styles.MyDaysTextStyle),
                ],
              ),
            ]),
          ),
        ]);
  }
}
