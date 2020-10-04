import 'package:daily_logger/services/config_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:daily_logger/models/log.dart';

final _sl = GetIt.I;
typedef AnimateScroll(int position);

class LogProvider extends ChangeNotifier {
  // ConfigProvider _config;
  Box _logsBox;
  List<Log> get boxedLogs => List<Log>.from(_logsBox.values);

  List<Log> logs;
  Set<String> filters;
  String grepString;

  bool viewNeedsUpdate;

  Log lastLog;
  int scrollTarget;
  Map<String, AnimateScroll> _scrollers;

  LogProvider() {
    // _config = _sl<ConfigProvider>();

    _scrollers = Map<String, AnimateScroll>();

    _logsBox = Hive.box('logs');

    filters = {};
    grepString = '';
    viewNeedsUpdate = false;

    logs = boxedLogs;
  }

  // bool get sortAscend => _config.sortAscend.value;
  // set sortAscend(bool newValue) => _config.sortAscend.value = newValue;

  int get nextId =>
      _logsBox.length == 0 ? 0 : _logsBox.keyAt(_logsBox.length - 1);

  @override
  dispose() {
    super.dispose();
  }

  updateView() {
    if (viewNeedsUpdate) {
      notifyListeners();
      logs = boxedLogs.where((log) => notFiltersOut(log)).toList();

      viewNeedsUpdate = false;
      notifyListeners();
    }
    if (lastLog != null) {
      scrollTarget = logs.indexOf(lastLog);
      _scrollers.forEach((key, value) => value(scrollTarget));
      lastLog = null;
    }
  }

  notFiltersOut(Log log) {
    return (filters.isEmpty ||
            filters.any((filter) => log.content.contains(filter))) &&
        (grepString.isEmpty || log.content.contains(grepString));
  }

  setGrepString(String filter) {
    // print('filter updated');
    grepString = filter;
    viewNeedsUpdate = true;
    updateView();
  }

  toggleFilter(String filter) {
    if (!filters.remove(filter)) filters.add(filter);
    viewNeedsUpdate = true;
    updateView();
  }

  createLog(Log log) {
    log
      ..id = nextId + 1
      ..created = DateTime.now()
      ..lastUpdate = DateTime.now();
    _logsBox.put(log.id, log);

    lastLog = log;
    viewNeedsUpdate = notFiltersOut(log);
    updateView();
  }

  removeLog(Log log) {
    _logsBox.delete(log.id);

    viewNeedsUpdate = notFiltersOut(log);
    updateView();
  }

  updateLog(Log log) {
    log.lastUpdate = DateTime.now();
    _logsBox.put(log.id, log);
    lastLog = log;

    viewNeedsUpdate = notFiltersOut(log);
    updateView();
  }

  addScroller(String name, AnimateScroll scroller) =>
      _scrollers[name] = scroller;
  removeScroller(String name) => _scrollers.remove(name);
}
