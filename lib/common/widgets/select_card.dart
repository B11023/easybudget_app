import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  final String text;                
  final bool isSelected;           
  final VoidCallback onTap;             

  const SelectCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.main : AppColors.disIcon,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.invist,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
