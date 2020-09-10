import 'package:aba/constants/Styles.dart';
import 'package:aba/dao/AlarmDao.dart';
import 'package:aba/dao/objects/AlarmData.dart';
import 'package:flutter/material.dart';

class NewAlarmWidget extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NewAlarmWidget> {
  TextEditingController _editingController;

  @override
  void initState() {
    _editingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: showLabelEditDialog,
        backgroundColor: Styles.MyLighterAccent,
        child: Icon(Icons.add));
  }

  void showLabelEditDialog() {
    AlarmData alarm = new AlarmData(label: "Default");

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
                  controller: _editingController,
                  style: Styles.MyDaysTextStyle,
                  cursorColor: Styles.MyLighterAccent,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    onPressed: () => _editingController.clear(),
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
                    ).then((value) => setState(() {
                          if (value != null) {
                            alarm.time = value;
                          }
                        }));
                  },
                  child: Text(
                    alarm.time.format(context),
                    style: Styles.MyAlarmTextStyle,
                  )),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  AlarmDao.addAlarm(alarm);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
