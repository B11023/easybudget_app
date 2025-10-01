import 'package:flutter/material.dart';

IconData appIcon(dynamic index) {
  switch (index) {
    case 'Salary':
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
    default:
      return Icons.question_mark;
  }
}
