import 'package:daily_logger/services/config_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/log.dart';

final _sl = GetIt.I;
typedef AnimateScroll(int position);

class LogProvider extends ChangeNotifier {
  ConfigProvider _config;
  Box _logsBox;
  List<Log> _logs;
  Set<String> filters;
  Log lastLog;

  bool logsUpdated;
  int scrollTarget;
  Map<String, AnimateScroll> _scrollers;

  LogProvider() {
    _config = _sl<ConfigProvider>();

    _scrollers = Map<String, AnimateScroll>();

    _logsBox = Hive.box('logs');
    logsUpdated = true;
    _logs = logs;
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
    // print('getLogs');
    // TODO implement filtering
    // repopulate logs after some of em changed
    if (logsUpdated) {
      _logs = List<Log>.from(_logsBox.values)
          // .where((e) => e.value.tags.every((tag) => filters.contains(tag)))
          .toList();
      _logs.sort(
          (a, b) => (sortAscend ? 1 : -1) * a.created.compareTo(b.created));

      scrollTarget =
          lastLog == null ? _logs.length - 1 : _logs.indexOf(lastLog);
      _scrollers.forEach((key, value) => value(scrollTarget));
      lastLog = null;

      logsUpdated = false;
    }
    return _logs;
  }

  createLog(Log log) {
    log
      ..id = nextId + 1
      ..created = DateTime.now()
      ..lastUpdate = DateTime.now();
    _logsBox.put(log.id, log);
    logsUpdated = true;
    // lastLog = log;
    notifyListeners();
  }

  removeLog(Log log) {
    _logsBox.delete(log.id);
    logsUpdated = true;
    notifyListeners();
  }

  updateLog(Log log) {
    log.lastUpdate = DateTime.now();
    _logsBox.put(log.id, log);
    lastLog = log;
    logsUpdated = true;
    notifyListeners();
  }

  addScroller(String name, AnimateScroll scroller) =>
      _scrollers[name] = scroller;
  removeScroller(String name) => _scrollers.remove(name);
}
