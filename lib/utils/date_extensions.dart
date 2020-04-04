import 'package:intl/intl.dart';

extension MyDateUtils on DateTime {
  String get hourMinute => DateFormat.Hm().format(this);
  String get hourMinuteSecond => DateFormat.Hms().format(this);
  String get monthDay => DateFormat.MMMMd().format(this);
  bool sameDateWith(DateTime other) =>
      this.year == other.year &&
      this.month == other.month &&
      this.day == other.day;
}
