const Map<String, double> _ratios = {
  'USD': 1,
  'BYN': 2.34,
  'RUB': 72.62,
  'EUR': 0.9,
  'UAH': 26.14,
};

class Exchange {
  static convert(double value, String from, String to) =>
      value / _ratios[from] * _ratios[to];
}
