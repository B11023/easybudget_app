import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final IconData icon;
  final String label;
  final String percent;
  final String amount;

  const TransactionList({
    Key? key,
    required this.icon,
    required this.label,
    required this.percent,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(icon),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '  $label',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                percent,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(''),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                amount,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
