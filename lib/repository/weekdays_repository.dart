import 'package:aba/model/Day.dart';

class WeekDays {
  static List<Day> daysOfTheWeek = ({
    new Day(day: "Monday", shortDay: "M"),
    new Day(day: "Tuesday", shortDay: "T"),
    new Day(day: "Wednesday", shortDay: "W"),
    new Day(day: "Thursday", shortDay: "T"),
    new Day(day: "Friday", shortDay: "F"),
    new Day(day: "Saturday", shortDay: "S"),
    new Day(day: "Sunday", shortDay: "S"),
  }).toList();
}
