import 'package:aba/dao/objects/Day.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class AlarmData {
  String label;
  TimeOfDay time = new TimeOfDay(hour: 0, minute: 00);
  bool repeatMon = false,
      repeatTues = false,
      repeatWeds = false,
      repeatThurs = false,
      repeatFri = false,
      repeatSat = false,
      repeatSun = false;
  bool enabled = true;
  String sound;

  AlarmData({this.label});

  bool isActiveForDay(Day day) {
    switch (day.day) {
      case "Monday":
        return repeatMon;
      case "Tuesday":
        return repeatTues;
      case "Wednesday":
        return repeatWeds;
      case "Thursday":
        return repeatThurs;
      case "Friday":
        return repeatFri;
      case "Saturday":
        return repeatSat;
      case "Sunday":
        return repeatSun;
      default:
        developer.log("Unable to recognise day to return status");
        return false;
    }
  }

  void switchStateOfDay(Day day) {
    switch (day.day) {
      case "Monday":
        repeatMon = !repeatMon;
        break;
      case "Tuesday":
        repeatTues = !repeatTues;
        break;
      case "Wednesday":
        repeatWeds = !repeatWeds;
        break;
      case "Thursday":
        repeatThurs = !repeatThurs;
        break;
      case "Friday":
        repeatFri = !repeatFri;
        break;
      case "Saturday":
        repeatSat = !repeatSat;
        break;
      case "Sunday":
        repeatSun = !repeatSun;
        break;
      default:
        developer.log("Unable to recognise day to switch the status");
        return;
    }
  }
}
