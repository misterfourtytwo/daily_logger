import 'dart:math';
import 'package:daily_logger/services/config_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/log.dart';

final _sl = GetIt.I;

List<Log> stubLogs = [
  Log(title: 'zero', content: 'two', id: 'id1'),
  Log(title: 'naruto', content: 'uzumaki', id: 'id2')
];

class LogProvider extends ChangeNotifier {
  Box _box;
  Map<String, Log> _logs;
  bool sortAscend;
  int nextId;
  Set<String> filters;

  LogProvider() {
    print('init provider');

    var config = _sl.get<ConfigProvider>();
    sortAscend = config.sortAscend;
    nextId = config.nextId;

    _box = Hive.box('logs');

    _logs = Map<String, Log>.from(_box.toMap());
    // stubLogs.forEach((e) => _logs[e.id] = e);
    print('init finish');
  }

  List<Log> get logs {
    // TODO filter
    print('getLogs');

    var data = _logs.entries
        // .where((e) => e.value.tags.every((tag) => filters.contains(tag)))
        .map((e) => e.value)
        .toList();
    data.sort((a, b) => (sortAscend ? -1 : 1) * a.created.compareTo(b.created));

    return data;
  }

  createLog(Log log) {
    final rand = Random();
    final id = rand.nextInt(65536).toString() + rand.nextInt(65536).toString();
    log
      ..id = id
      ..lastUpdate = DateTime.now()
      ..created = DateTime.now();
    _logs[id] = log;
    notifyListeners();
  }

  updateLog(Log log) {
    log.lastUpdate = DateTime.now();
    _logs[log.id] = log;
    notifyListeners();
  }
}
