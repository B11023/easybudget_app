import 'package:flutter/material.dart';

class CategoryStatItem {
  final IconData icon;
  final String label;
  final String percent;
  final String amount;

  const CategoryStatItem({
    required this.icon,
    required this.label,
    required this.percent,
    required this.amount,
  });
}
