import 'package:daily_logger/models/log_types.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ConfigProvider extends ChangeNotifier {
  Box _box;

  bool sortAscend;
  int nextId;
  LogTypes activeType;

  ConfigProvider() {
    _box = Hive.box('config');
    // log list
    sortAscend = _box.get('sortAscend', defaultValue: true);
    // create log
    nextId = _box.get('nextId', defaultValue: 1);
    activeType = _box.get('activeType', defaultValue: LogTypes.note);
    //
  }
}
