import 'package:daily_logger/config/exchange.dart';

class Currency {
  double value;
  double get inUsd => value;
  double get inBYN => Exchange.convert(value, 'USD', 'BYN');
  double get inRUB => Exchange.convert(value, 'USD', 'RUB');
  double get inEUR => Exchange.convert(value, 'USD', 'EUR');
  double get inUAH => Exchange.convert(value, 'USD', 'UAH');
}
