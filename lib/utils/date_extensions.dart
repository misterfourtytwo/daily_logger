import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO convert to utc when backing up on server
extension MyDateUtils on DateTime {
  DateTime get date => DateTime(this.year, this.month, this.day);
  String get hourMinute => DateFormat.Hm().format(this);
  String get hourMinuteSecond => DateFormat.Hms().format(this);
  String get monthDay => DateFormat.MMMMd().format(this);
  String get yearMonthDay => DateFormat.yMd().format(this);
  bool get dateEmpty => this == DateTime(0);
  bool sameDateWith(DateTime other) =>
      this.year == other.year &&
      this.month == other.month &&
      this.day == other.day;
  TimeOfDay get time => TimeOfDay.fromDateTime(this);

  DateTime copyWith(
      {int year,
      int month,
      int day,
      int hour,
      int minute,
      int second,
      int millisecond,
      int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime copyWithTime(TimeOfDay newTime) {
    // int uSecondsSinceEpoch = this.date.microsecondsSinceEpoch +
    //     (newTime?.hour ?? 0) * 3600 * 1000 +
    //     (newTime?.minute ?? 0) * 60 * 1000;
    // return DateTime.fromMillisecondsSinceEpoch(uSecondsSinceEpoch,
    //     isUtc: false);
    return this.date.copyWith(hour: newTime?.hour, minute: newTime?.minute);
  }
}
