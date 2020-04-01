import 'package:daily_logger/services/config_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/log.dart';

final _sl = GetIt.I;

class LogProvider extends ChangeNotifier {
  ConfigProvider _config;
  Box _logsBox;
  // Map<int, Log> _logs;
  Set<String> filters;

  LogProvider() {
    // print('init provider');

    _config = _sl<ConfigProvider>();

    _logsBox = Hive.box('logs');
    // _logs = Map<int, Log>.from(_logsBox.toMap());
  }

  bool get sortAscend => _config.sortAscend.value;
  set sortAscend(bool newValue) => _config.sortAscend.value = newValue;

  int get nextId =>
      _logsBox.length == 0 ? 0 : _logsBox.keyAt(_logsBox.length - 1);

  @override
  dispose() {
    super.dispose();
  }

  List<Log> get logs {
    // TODO implement filtering
    print('getLogs');
    var data = Map<int, Log>.from(_logsBox.toMap())
        .entries
        // .where((e) => e.value.tags.every((tag) => filters.contains(tag)))
        .map((e) => e.value)
        .toList();
    data.sort((a, b) => (sortAscend ? 1 : -1) * a.created.compareTo(b.created));

    return data;
  }

  createLog(Log log) {
    log
      ..id = nextId + 1
      ..created = DateTime.now()
      ..lastUpdate = DateTime.now();
    _logsBox.put(log.id, log);
    notifyListeners();
  }

  removeLog(Log log) {
    _logsBox.delete(log.id);
    notifyListeners();
  }

  updateLog(Log log) {
    _logsBox.put(log.id, log
        // (Log value) {
        //   log.lastUpdate = DateTime.now();
        //   _logs[log.id] = log;
        //   return log;
        // },
        // ifAbsent: () {
        //   print('log with id #${log.id} not found');
        //   return log;
        // },
        );
    notifyListeners();
  }
}
