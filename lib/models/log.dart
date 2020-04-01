import 'package:daily_logger/models/log_types.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/currency.dart';

part 'log.g.dart';

@HiveType(typeId: 0)
class Log {
  @HiveField(0)
  String id;
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

  Log(
      {this.id,
      this.title = '',
      this.content = '',
      this.tags = const [],
      this.created}) {
    // created = created ?? DateTime.now();
    isInstant = true;
    isTask = false;
    isPayment = false;
  }

  // factory Log.empty() => Log();
  factory Log.note() {}
  factory Log.continuous() {}
  factory Log.payment() {}
  factory Log.task() {}

  Duration get elapsed => isInstant ? 0 : started.difference(finished);

  @override
  String toString() {
    return 'log-${created.toLocal()}:  ${this.title} - ${this.content}';
  }
}
