import 'package:aba/dao/objects/AlarmData.dart';

class AlarmDao {
  static List<AlarmData> testListOfAlarms = ({
    AlarmData(label: "One"),
    AlarmData(label: "Two"),
    AlarmData(label: "Three"),
    AlarmData(label: "Four"),
  }).toList();

  static List<AlarmData> getAlarms() {
    return testListOfAlarms;
  }

  static void addAlarm(AlarmData newAlarm) {
    testListOfAlarms.add(newAlarm);
  }
}
