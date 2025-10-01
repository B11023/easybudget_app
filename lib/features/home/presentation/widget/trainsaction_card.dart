import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/provider/load_status.dart';
import 'package:easybudget_app/common/services/app_currency.dart';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TrainsactionCard extends StatefulWidget {
  const TrainsactionCard({super.key});
  @override
  State<TrainsactionCard> createState() => _TrainsactionCardState();
}

class _TrainsactionCardState extends State<TrainsactionCard> {
  @override
  Widget build(BuildContext context) {
    String label;
    List<IconData>? icons;
    List<String> titles;
    List<String> trailing;
    List<Color> trailingColors;

    final provider = context.watch<EntryProvider>();
    final grouped = provider.groupedByDay;
    final days = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    if (provider.status == LoadStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.status == LoadStatus.error) {
      return Center(child: Text('載入失敗：${provider.error}'));
    }
    if (grouped.isEmpty) {
      return const Center(child: Text('本月沒有資料'));
    }

    return ListView.builder(
      // controller: _scrollController,
      itemCount: days.length,
      itemBuilder: (context, index) {
        final date = days[index];
        final list = grouped[date]!;
        label = DateFormat('MM/dd').format(date);
        icons = list.map((e) => appIcon(e.category)).cast<IconData>().toList();
        titles = list
            .map((e) => e.note?.trim().isNotEmpty == true ? e.note! : "")
            .toList();
        trailing =
            list.map((e) => formatCurrency(e.amount, e.entryType)).toList();
        trailingColors = list
            .map((e) => e.entryType == 'income' ? Colors.green : Colors.red)
            .toList();

        return Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 27, right: 27, bottom: 25),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: AppColors.lightMain,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 56.0,
                      margin: EdgeInsets.only(
                        top: index == 0 ? 24.0 : 0,
                        right: 13,
                        left: 13,
                        bottom: 21,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.invist,
                      ),
                      child: ListTile(
                        leading: Icon(icons?[index]),
                        title: Text(titles[index]),
                        trailing: Text(
                          trailing[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: trailingColors[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: -15,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 10.0),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: AppColors.lightFont,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
