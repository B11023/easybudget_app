import 'dart:developer';

import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:easybudget_app/features/home/presentation/add_transaction.dart';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/common/widgets/base_scaffold.dart';
import 'package:easybudget_app/features/home/presentation/trainsaction_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    //偵測滾動位置
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      log('bottom');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: const Center(
              child: SizedBox(
            height: 0,
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const AddTransactionWidget());
          },
          foregroundColor: AppColors.lightFont,
          backgroundColor: AppColors.main,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Divider(
                        thickness: 2,
                        height: 30,
                        color: AppColors.font,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Icon(
                          Icons.menu_book,
                          size: 55,
                          color: AppColors.font,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Divider(
                      thickness: 2,
                      height: 120,
                      color: AppColors.font,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return TrainsactionCard(
                    label: "08/31",
                    itemCount: 3,
                    icons: [appIcon(1), appIcon(2), appIcon(3)],
                    titles: const ["搬家", "ECO", "交通"],
                    trailing: const ["\$100", "\$200", "\$300"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
