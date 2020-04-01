import 'package:hive/hive.dart';

import 'package:daily_logger/config/exchange.dart';

part 'currency.g.dart';

@HiveType(typeId: 2)
class Currency {
  @HiveField(0)
  double value;

  Currency([this.value = 0]);

  double get inUsd => value;
  double get inBYN => Exchange.convert(value, 'USD', 'BYN');
  double get inRUB => Exchange.convert(value, 'USD', 'RUB');
  double get inEUR => Exchange.convert(value, 'USD', 'EUR');
  double get inUAH => Exchange.convert(value, 'USD', 'UAH');
}
