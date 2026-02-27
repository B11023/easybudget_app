import 'dart:developer';

import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/widgets/month_switcher.dart';
import 'package:easybudget_app/features/home/add_transaction.dart';
import 'package:easybudget_app/common/widgets/base_scaffold.dart';
import 'package:easybudget_app/features/home/trainsaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EntryProvider>().resetToNow();
    });
  }

  void _scrollListener() {
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
          automaticallyImplyLeading: false,
          toolbarHeight: 20,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => AddTransactionWidget());
          },
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: Divider(
                        thickness: 2,
                        height: 30,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Divider(
                      thickness: 2,
                      height: 120,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  MonthSwitcher(),
                  Expanded(
                    flex: 1,
                    child: Divider(
                      thickness: 2,
                      height: 120,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TrainsactionCard(),
            ),
          ],
        ),
      ),
    );
  }
}
