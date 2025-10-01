import 'package:intl/intl.dart';

String formatCurrency(int v , String incomeType) {
  String type = '-';
  if (incomeType=='income'){
    type='+';
  }

  final f = NumberFormat.currency(
    locale: 'zh_TW',
    symbol: '$type NT\$',
    decimalDigits: 0,
  );
  return f.format(v);
}
