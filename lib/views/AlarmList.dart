import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmList extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          if (index < testListOfAlarms.length) {
            return _buildRow(testListOfAlarms[index]);
          }
          return null;
        });
  }

  Widget _buildRow(AlarmData data) {
    return AlarmListItem(data: data);
  }
}

class AlarmListItem extends StatelessWidget {
  final AlarmData data;
  AlarmListItem({this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.label),
    );
  }
}

class AlarmData {
  String label;
  AlarmData({this.label});
}

List<AlarmData> testListOfAlarms =
    ({AlarmData(label: "one"), AlarmData(label: "two")}).toList();
