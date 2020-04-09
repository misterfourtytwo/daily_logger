import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/payment.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/log_provider.dart';
import 'package:daily_logger/utils/date_extensions.dart';

final _sl = GetIt.instance;

class CreateLogProvider extends ChangeNotifier {
  int editId;
  // ValueNotifier<LogTypes> type;
  LogTypes type;
  String title = '', content = '', price = '';
  bool paymentPaid, taskCompleted;
  DateTime deadlineDate, businessStartDate, businessEndDate;
  TimeOfDay deadlineTime, businessStartTime, businessEndTime;

  Function fieldSetter;

  Box _box;
  LogProvider _logs;

  CreateLogProvider(Function fieldSetter) {
    _box = Hive.box('create log');
    _logs = _sl<LogProvider>();

    // type
    type =
        // ValueNotifier<LogTypes>
        (_box.get('type', defaultValue: LogTypes.note));
    // type.addListener(() {
    //   _box.put('type', type.value);
    // });
  }

  void saveLog() {
    Log log;
    switch (type) {
      case LogTypes.payment:
        log = Log.payment(
          title: title,
          content: content,
          price: Payment(double.tryParse(price)),
          alreadyPaid: paymentPaid,
        );
        break;

      case LogTypes.continuous:
        log = Log.continuous(
          title: title,
          content: content,
          start: (businessStartDate ?? DateTime(0))
              .copyWithTime(businessStartTime),
          finish:
              (businessEndDate ?? DateTime(0)).copyWithTime(businessEndTime),
        );
        break;

      case LogTypes.task:
        log = Log.task(
          title: title,
          content: content,
          deadline: (deadlineDate ?? DateTime(0)).copyWithTime(deadlineTime),
          completed: taskCompleted,
        );
        break;

      case LogTypes.note:
      default:
        log = Log.note(
          title: title,
          content: content,
        );
    }
    _logs.createLog(log);
    clearData();
    notifyListeners();
  }

  void clearData() {
    editId = null;
    title = '';
    content = '';
    price = '';
    taskCompleted = false;
    deadlineTime = null;
    deadlineDate = null;
    businessStartDate = null;
    businessEndDate = null;
    businessStartTime = null;
    businessEndTime = null;
  }

  @override
  void dispose() {
    // type.dispose();
    super.dispose();
  }
}
