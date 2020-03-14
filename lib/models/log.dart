import 'package:daily_logger/models/currency.dart';

class Log {
  String title;
  String content;
  DateTime created;

  List<String> tags;

  bool isInstant;
  DateTime started;
  DateTime finished;
  Duration get elapsed => isInstant ? 0 : started.difference(finished);

  bool isTask;
  DateTime deadline;
  bool completed;

  bool needsPayment;
  Currency price;
  bool isPaid;
}
