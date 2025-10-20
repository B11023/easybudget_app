import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCard extends StatefulWidget {
  const SelectCard({
    super.key,
    required this.text,
    required this.type,
  });

  @override
  State<SelectCard> createState() => _SelectCardState();

  final String text;
  final bool type;
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EntryProvider>();
    final bool isActive = (provider.isSelected == widget.type);

    return Card(
      color: isActive ? AppColors.main : AppColors.disIcon,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          provider.setSelected(widget.type);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            widget.text,
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
