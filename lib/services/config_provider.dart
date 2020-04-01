import 'package:daily_logger/models/log_types.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ConfigProvider extends ChangeNotifier {
  Box _box;

  ValueNotifier<bool> sortAscend;
  // int get nextId => _box.get('nextId', defaultValue: 0);
  // set nextId(int newValue) => _box.put('nextId', newValue);
  ValueNotifier<LogTypes> activeType;

  ConfigProvider() {
    _box = Hive.box('config');
    // log list
    sortAscend =
        ValueNotifier<bool>(_box.get('sortAscend', defaultValue: true));
    sortAscend.addListener(() {
      _box.put('sortAscend', sortAscend.value);
    });

    // create log
    activeType = ValueNotifier<LogTypes>(
        _box.get('activeType', defaultValue: LogTypes.note));
    activeType.addListener(() {
      _box.put('activeType', activeType.value);
    });
  }

  @override
  void dispose() {
    sortAscend.dispose();
    activeType.dispose();
    super.dispose();
  }
}
