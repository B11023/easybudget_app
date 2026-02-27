import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearSwitcher extends StatelessWidget {
  const YearSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EntryProvider>();
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_left),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          padding: EdgeInsets.only(top: 5),
          constraints: const BoxConstraints(
            minWidth: 28,
            minHeight: 28,
          ),
          visualDensity: VisualDensity.compact,
          onPressed: () {
            provider.previousYear();
            debugPrint('year--');
          },
        ),
        Text(
          ' ${provider.year}年',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        IconButton(
          icon: Icon(Icons.arrow_right),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          padding: EdgeInsets.only(top: 5),
          constraints: const BoxConstraints(
            minWidth: 28,
            minHeight: 28,
          ),
          visualDensity: VisualDensity.compact,
          onPressed: () {
            provider.nextYear();
            debugPrint('year++');
          },
        ),
      ],
    );
  }
}
