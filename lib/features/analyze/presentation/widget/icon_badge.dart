import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final String categoryKey;
  const IconBadge({super.key, required this.categoryKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 26,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            appIcon(categoryKey),
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
