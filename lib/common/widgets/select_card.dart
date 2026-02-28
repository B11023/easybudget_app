import 'package:easybudget_app/common/models/entry_type.dart';
import 'package:easybudget_app/common/provider/entry_provider.dart';
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
  final EntryType type;
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EntryProvider>();
    final bool isActive = (provider.selectedType == widget.type);

    return Card(
      color: isActive
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          provider.setSelectedType(widget.type);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            widget.text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
