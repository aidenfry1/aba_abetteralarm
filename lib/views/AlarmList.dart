import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AlarmList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AlarmList> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, i) {
          if (i.isOdd)
            return Divider(
              color: Color(0xFF4E1EEB),
            );

          final index = i ~/ 2;

          if (index < testListOfAlarms.length) {
            return _buildRow(testListOfAlarms[index]);
          }
          return null;
        });
  }

  Widget _buildRow(AlarmData data) {
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Text("6:00", style: myAlarmTextStyle),
            Switch(
              value: data.isActive,
              onChanged: (value) {
                setState(() {
                  data.isActive = value;
                });
              },
              inactiveTrackColor: Colors.white30,
//              activeColor: Colors.green,
            ),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
        ],
      ),
      subtitle: Wrap(
        spacing: 4, // set spacing here
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundColor: Color.fromARGB(255, 132, 101, 235),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Color.fromARGB(255, 36, 14, 107),
              child: Center(
                child: Text("M", style: myDaysTextStyle),
              ),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              border: new Border.all(
                color: Color.fromARGB(255, 132, 101, 235),
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text("T", style: myDaysTextStyle),
            ),
          ),
          Text("T", style: myDaysTextStyle),
          Text("W", style: myDaysTextStyle),
          Text("T", style: myDaysTextStyle),
          Text("F", style: myDaysTextStyle),
          Text("S", style: myDaysTextStyle),
          Text("S", style: myDaysTextStyle),
        ],
      ),
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Sound", style: myDaysTextStyle),
                    Text("Oxygen", style: myDaysTextStyle)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Label", style: myDaysTextStyle),
                    Text(data.label, style: myDaysTextStyle)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Delete", style: myDaysTextStyle),
                    Text("Skip ", style: myDaysTextStyle),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}

final myAlarmTextStyle = TextStyle(color: Colors.white, fontSize: 24);

final myDaysTextStyle = TextStyle(color: Colors.white, fontSize: 20);

class AlarmData {
  String label;
  TimeOfDay time;
  bool repeatMon,
      repeatTues,
      repeatWeds,
      repeatThurs,
      repeatFri,
      repeatSat,
      repeatSun;
  bool isActive = true;
  bool isExpanded = true;
  String sound;

  AlarmData({this.label});
}

List<AlarmData> testListOfAlarms = ({
  AlarmData(label: "One"),
  AlarmData(label: "Two"),
  AlarmData(label: "Three"),
  AlarmData(label: "Four"),
}).toList();
