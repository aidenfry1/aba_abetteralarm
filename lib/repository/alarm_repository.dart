import 'dart:collection';

import 'package:aba/model/Alarm.dart';
import 'package:flutter/cupertino.dart';

class AlarmChangeNotifier extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  UnmodifiableListView<Alarm> get alarms => UnmodifiableListView(_alarms);

  void add(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void update(Alarm oldAlarm, Alarm newAlarm) {
    int index = _alarms.indexOf(oldAlarm);
    _alarms.removeAt(index);
    _alarms.insert(index, newAlarm);

    notifyListeners();
  }

  void removeAll() {
    _alarms.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
