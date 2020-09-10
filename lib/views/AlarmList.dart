import 'package:aba/constants/Styles.dart';
import 'package:aba/dao/AlarmDao.dart';
import 'package:aba/dao/DaysDao.dart';
import 'package:aba/dao/objects/AlarmData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AlarmList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AlarmList> with TickerProviderStateMixin {
  TextEditingController _editingController;
  @override
  void initState() {
    _editingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd)
        return Divider(
          color: Color(0xFF4E1EEB),
        );

      final index = i ~/ 2;

      if (index < AlarmDao.getAlarms().length) {
        return _buildRow(AlarmDao.getAlarms()[index]);
      }
      return null;
    });
  }

  Widget _buildRow(AlarmData alarm) {
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
                  Switch(
                    value: alarm.enabled,
                    onChanged: (value) {
                      setState(() {
                        alarm.enabled = value;
                      });
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
              children: DaysDao.daysOfTheWeek
                  .map<Widget>((day) => GestureDetector(
                        onTap: () {
                          setState(() {
                            alarm.switchStateOfDay(day);
                          });
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
                        showLabelEditDialog(alarm);
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

  void showLabelEditDialog(AlarmData alarm) {
    _editingController.text = alarm.label;
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
                    setState(() {
                      alarm.label = newValue;
                    });
                    Navigator.pop(context);
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
              )
            ],
          );
        });
  }
}
