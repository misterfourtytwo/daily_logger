import 'package:daily_logger/models/log_types.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/currency.dart';

part 'log.g.dart';

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
  Currency price;
  @HiveField(15)
  bool isPaid;

  DateTime get date =>
      (isTask ? deadline : isInstant ? started : finished ?? started) ??
      created;

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

  factory Log.payment() {
    final log = Log();
    log.type = LogTypes.payment;
    log.title = '';
    log.content = '';
    log.tags = [];
    log.isInstant = true;
    log.isTask = false;
    log.isPayment = true;
    log.isPaid = false;
    log.price = Currency();
    return log;
  }
  factory Log.task() {
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

  Duration get elapsed => isInstant ? 0 : started.difference(finished);

  @override
  String toString() {
    return 'log-${created.toLocal()}:  ${this.title} - ${this.content}';
  }
}
