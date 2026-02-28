import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthSwitcher extends StatelessWidget {
  const MonthSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EntryProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_left,
            size: 40,
          ),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          padding: const EdgeInsets.only(top: 10),
          constraints: const BoxConstraints(
            minWidth: 28,
            minHeight: 28,
          ),
          visualDensity: VisualDensity.compact,
          onPressed: () {
            provider.previousMonth();
            debugPrint('month--');
          },
        ),
        SizedBox(
          width: 110,
          child: Center(
            child: IntrinsicWidth(
              child: Text(
                '${provider.year}年 ${provider.month}月',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_right,
            size: 40,
          ),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          padding: EdgeInsets.only(top: 10),
          constraints: const BoxConstraints(
            minWidth: 28,
            minHeight: 28,
          ),
          visualDensity: VisualDensity.compact,
          onPressed: () {
            provider.nextMonth();
            debugPrint('month++');
          },
        ),
      ],
    );
  }
}
