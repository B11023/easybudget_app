import 'package:intl/intl.dart';

String formatCurrency(int v, String incomeType) {
  String type = '-';
  if (incomeType == 'income') {
    type = '+';
  }

  final f = NumberFormat.currency(
    locale: 'zh_TW',
    symbol: '$type NT\$',
    decimalDigits: 0,
  );
  return f.format(v);
}

String formatAmount(double value) {
  final abs = value.abs();

  if (abs >= 1000000) {
    return '\$ ${(value / 1000000).toStringAsFixed(0)}M';
  } else if (abs >= 1000) {
    return '\$ ${(value / 1000).toStringAsFixed(0)}K';
  } else {
    return '\$ ${value.toInt()}';
  }
}
