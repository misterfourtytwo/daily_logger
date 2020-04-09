import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ConfigProvider extends ChangeNotifier {
  Box _box;

  ValueNotifier<bool> sortAscend;
  ValueNotifier<bool> grepToggle;

  // int get nextId => _box.get('nextId', defaultValue: 0);
  // set nextId(int newValue) => _box.put('nextId', newValue);

  ConfigProvider() {
    _box = Hive.box('config');
    // log list
    sortAscend =
        ValueNotifier<bool>(_box.get('sortAscend', defaultValue: true));
    sortAscend.addListener(() {
      _box.put('sortAscend', sortAscend.value);
    });

    // log
    // grep
    grepToggle =
        ValueNotifier<bool>(_box.get('grepToggle', defaultValue: false));
    sortAscend.addListener(() {
      _box.put('grepToggle', grepToggle.value);
    });
  }

  @override
  void dispose() {
    grepToggle.dispose();
    sortAscend.dispose();
    super.dispose();
  }
}
