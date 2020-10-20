import 'package:aba/constants/Styles.dart';
import 'package:aba/model/Alarm.dart';
import 'package:aba/repository/alarm_repository.dart';
import 'package:aba/screen/main_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewAlarmWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final alarmChangeNotifier = watch(alarmChangeNotifierProvider);
    TextEditingController _editingController;

    return FloatingActionButton(
        onPressed: () => showLabelEditDialog(
            context, _editingController, alarmChangeNotifier),
//        onPressed: () => {alarmChangeNotifier.add(new Alarm(label: "test"))},
        backgroundColor: Styles.MyLighterAccent,
        child: Icon(Icons.add));
  }

  void showLabelEditDialog(
      BuildContext context,
      TextEditingController editingController,
      AlarmChangeNotifier alarmChangeNotifier) {
    Alarm alarm = new Alarm(label: "Default");

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Set Label", style: Styles.MyDaysTextStyle),
            backgroundColor: Styles.MyBackgroundColor,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                child: new TextField(
                  onSubmitted: (newValue) {
                    alarm.label = newValue;
                  },
                  autofocus: true,
                  controller: editingController,
                  style: Styles.MyDaysTextStyle,
                  cursorColor: Styles.MyLighterAccent,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    onPressed: () => editingController.clear(),
                    icon: Icon(Icons.clear),
                    color: Colors.white,
                  )),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    showTimePicker(
                      initialTime: alarm.time,
                      context: context,
                      initialEntryMode: TimePickerEntryMode.dial,
                    ).then((value) => {
                          if (value != null) {alarm.time = value}
                        });
                  },
                  child: Text(
                    alarm.time.format(context),
                    style: Styles.MyAlarmTextStyle,
                  )),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context, alarm);
                },
              )
            ],
          );
        }).then((value) {
      if (value != null) {
        alarmChangeNotifier.add(value);
      }
    });
  }
}
