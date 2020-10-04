import 'package:hive/hive.dart';

import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/models/payment.dart';

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

  // @HiveField(7)
  bool get isInstant => type != LogTypes.continuous;
  @HiveField(8)
  DateTime started;
  @HiveField(9)
  DateTime finished;

  // @HiveField(10)
  bool get isTask => type == LogTypes.task;
  @HiveField(11)
  DateTime deadline;
  @HiveField(12)
  bool completed;

  // @HiveField(13)
  bool get isPayment => type == LogTypes.payment;
  @HiveField(14)
  Payment price;
  @HiveField(15)
  bool alreadyPaid;

  DateTime get date {
    var res;
    // = (isTask ? deadline : isInstant ? started : finished ?? started);
    if (isTask) {
      res = deadline;
    } else if (!isInstant) {
      res = started;
    } else {
      res = finished == null || finished.year == 0 ? started : finished;
    }
    if (res == null || res.year == 0) res = created;
    return res;
  }

  Log()
      : created = DateTime.now(),
        lastUpdate = DateTime.now();
  factory Log.empty() => Log();

  factory Log.note({
    String title,
    String content,
  }) {
    final log = Log();
    log.type = LogTypes.note;
    log.title = title ?? '';
    log.content = content ?? '';
    log.tags = [];
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
    log.started = start;
    log.finished = finish;
    return log;
  }

  factory Log.task({
    String title,
    String content,
    DateTime deadline,
    bool completed,
  }) {
    final log = Log();
    log.type = LogTypes.task;
    log.title = title ?? '';
    log.content = content ?? '';
    log.tags = [];
    log.deadline = deadline;
    log.completed = completed ?? false;
    return log;
  }

  factory Log.payment({
    String title,
    String content,
    Payment price,
    bool alreadyPaid,
  }) {
    final log = Log();
    log.type = LogTypes.payment;
    log.title = title ?? '';
    log.content = content ?? '';
    log.tags = [];
    log.alreadyPaid = alreadyPaid ?? false;
    log.price = price;
    return log;
  }

  Duration get elapsed => isInstant ? 0 : started.difference(finished);

  @override
  String toString() {
    return 'log-${created.toLocal()}:  ${this.title} - ${this.content}';
  }
}
