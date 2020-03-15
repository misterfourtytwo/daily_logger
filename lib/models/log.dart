import 'package:daily_logger/models/currency.dart';

class Log {
  Log(
      {this.title = '',
      this.content = '',
      this.tags = const [],
      this.created}) {
    created = created ?? DateTime.now();
    isInstant = true;
    isTask = false;
    needsPayment = false;
  }

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

  factory Log.empty() => Log();

  @override
  String toString() {
    return 'log-${created.toLocal()}:  ${title} - ${content}';
  }
}
