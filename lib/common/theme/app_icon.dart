import 'package:flutter/material.dart';

IconData appIcon(dynamic index) {
  switch (index) {
    case 'hambuger':
    case '0':
      return Icons.lunch_dining;
    case 'hardware':
    case '1':
      return Icons.hardware;
    case 'eco':
    case '2':
      return Icons.eco;
    case 'subway':
    case '3':
      return Icons.directions_subway;
    case 'moto':
    case '4':
      return Icons.two_wheeler;
    case 'play':
    case '5':
      return Icons.sports_esports;
    case 'shopping':
    case '6':
      return Icons.shopping_cart;
    case 'phone':
    case '7':
      return Icons.phone_android;
    case 'paragliding':
    case '8':
      return Icons.paragliding;
    case 'bike':
    case '9':
      return Icons.pedal_bike;
    case 'paypal':
    case '10':
      return Icons.paypal;
    case 'gas':
    case '11':
      return Icons.local_gas_station;
    case '其他':
      return Icons.more_horiz;
    default:
      return Icons.question_mark;
  }
}

// Map<String, String> iconMap = {
//   '0': '飲食',
//   '1': '工具',
//   '2': '環保',
//   '3': '交通工具',
//   '4': '機車',
//   '5': '遊戲',
//   '6': '禮物',
//   '7': '水電費',
//   '8': '娛樂',
//   '9': '腳踏車',
//   '10': 'paypal',
//   '11': 'gas',
// };
