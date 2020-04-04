import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:universal_platform/universal_platform.dart';

import 'package:daily_logger/app.dart';
import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/payment.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/log_provider.dart';
import 'package:daily_logger/services/config_provider.dart';

final _sl = GetIt.instance;

void main() async {
  await _initHive();
  _initServices();
  runApp(App());
}

const _desktopDbPath =
// './db';
    '/home/mr42/Public/flutter/hive';

/// open database and boxes in it
_initHive() async {
  if (UniversalPlatform.isWeb ||
      UniversalPlatform.isAndroid ||
      UniversalPlatform.isIOS) {
    await Hive.initFlutter();
  } else {
    Hive.init(_desktopDbPath);
  }

  Hive.registerAdapter(PaymentAdapter());
  Hive.registerAdapter(LogTypesAdapter());
  Hive.registerAdapter(LogAdapter());

  await Hive.openBox('config');
  await Hive.openBox('logs')
      // ..clear()
      //
      ;
}

/// start and expose needed services
_initServices() {
  _sl.registerSingleton<ConfigProvider>(ConfigProvider());
  _sl.registerSingleton<LogProvider>(LogProvider());
}
