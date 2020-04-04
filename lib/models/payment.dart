import 'package:hive/hive.dart';

import 'package:daily_logger/config/exchange.dart';

part 'payment.g.dart';

const _currencySymbols = {'USD': '\$', 'EUR': '€', 'RUB': '₽', 'Bitcoin': '₿'};

@HiveType(typeId: 2)
class Payment {
  @HiveField(0)
  double value;
  @HiveField(1)
  String currency;
  @HiveField(2)
  DateTime timestamp;

  Payment([this.value = 0, this.currency = 'USD']);

  @override
  String toString() {
    if (currency == null) currency = 'USD';
    return value == null ? 'Unknown' : '$value ${_currencySymbols[currency]}';
  }

  Payment convertTo(String targetCurrency) =>
      Payment(Exchange.convert(this.value, this.currency, targetCurrency));

  // double get inUsd => value;
  // double get inBYN => Exchange.convert(value, 'USD', 'BYN');
  // double get inRUB => Exchange.convert(value, 'USD', 'RUB');
  // double get inEUR => Exchange.convert(value, 'USD', 'EUR');
  // double get inUAH => Exchange.convert(value, 'USD', 'UAH');
}
