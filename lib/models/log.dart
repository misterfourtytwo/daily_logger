import 'package:daily_logger/models/log_types.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/payment.dart';

part 'log.g.dart';

const _readableTypes = {
  LogTypes.task: 'task',
  LogTypes.note: 'note',
  LogTypes.payment: 'payment',
  LogTypes.complex: 'complex',
  LogTypes.continuous: 'continuous',
};

@HiveType(typeId: 0)
class Log {
  @HiveField(0)
  int id;
  @HiveField(1)
  LogTypes type;
  @HiveField(2)
  String title;
  @HiveField(3)
  String content;
  @HiveField(4)
  DateTime created;
  @HiveField(5)
  DateTime lastUpdate;

  @HiveField(6)
  List<String> tags;

  @HiveField(7)
  bool isInstant;
  @HiveField(8)
  DateTime started;
  @HiveField(9)
  DateTime finished;

  @HiveField(10)
  bool isTask;
  @HiveField(11)
  DateTime deadline;
  @HiveField(12)
  bool completed;

  @HiveField(13)
  bool isPayment;
  @HiveField(14)
  Payment price;
  @HiveField(15)
  bool alreadyPaid;

  DateTime get date =>
      (isTask ? deadline : isInstant ? started : finished ?? started) ??
      created;
  String get readableType => _readableTypes[type];

  Log();
  factory Log.empty() => Log();
  factory Log.note({
    String title,
    String content,
  }) {
    final log = Log();
    log.type = LogTypes.note;
    log.title = '';
    log.content = '';
    log.tags = [];
    log.isInstant = true;
    log.isTask = false;
    log.isPayment = false;
    return log;
  }

  factory Log.continuous({
    String title,
    String content,
    DateTime start,
    DateTime finish,
  }) {
    final log = Log();
    log.type = LogTypes.continuous;
    log.title = title ?? '';
    log.content = content ?? '';
    log.tags = [];
    log.isInstant = false;
    log.started = start;
    log.finished = finish;
    log.isTask = false;
    log.isPayment = false;
    return log;
  }

  factory Log.task() {
    final log = Log();
    log.type = LogTypes.task;
    log.title = '';
    log.content = '';
    log.tags = [];
    log.isInstant = true;
    log.isTask = true;
    log.completed = false;
    log.isPayment = false;
    return log;
  }

  factory Log.payment() {
    final log = Log();
    log.type = LogTypes.payment;
    log.title = '';
    log.content = '';
    log.tags = [];
    log.isInstant = true;
    log.isTask = false;
    log.isPayment = true;
    log.alreadyPaid = false;
    log.price = Payment();
    return log;
  }

  // factory Log.complex({
  //   isInstant = true,
  //   tags = const [],
  //   isTask = false,
  //   isPayment = false,
  // }) {
  //   final log = Log();
  //   log.type = LogTypes.complex;
  //   log.title = '';
  //   log.content = '';
  //   log.tags = tags;
  //   log.isInstant = isInstant;
  //   log.isTask = false;
  //   log.isPayment = true;
  //   log.alreadyPaid = false;
  //   log.price = Payment();
  //   return log;
  // }

  Duration get elapsed => isInstant ? 0 : started.difference(finished);

  @override
  String toString() {
    return 'log-${created.toLocal()}:  ${this.title} - ${this.content}';
  }
}
