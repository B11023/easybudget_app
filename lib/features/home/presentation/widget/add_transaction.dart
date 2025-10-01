import 'dart:developer';

import 'package:easybudget_app/common/models/entry.dart';
import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:easybudget_app/common/widgets/select_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddTransactionWidget extends StatefulWidget {
  const AddTransactionWidget({super.key});
  @override
  State<AddTransactionWidget> createState() => _AddTransactionWidget();
}

class _AddTransactionWidget extends State<AddTransactionWidget> {
  bool _isIncome = false;
  int? _selectionIndex;
  bool _selectionMainIcon = false;

  late final _amountCtrl = TextEditingController();
  late final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = context.read<EntryProvider>();
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.invist,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.font,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectCard(
                      text: '支出',
                      isSelected: !_isIncome,
                      onTap: () {
                        setState(
                          () {
                            _isIncome = false;
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 45.0),
                    SelectCard(
                      text: '收入',
                      isSelected: _isIncome,
                      onTap: () {
                        setState(
                          () {
                            _isIncome = true;
                          },
                        );
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.font,
                  onPressed: () async {
                    final text = _amountCtrl.text.trim();
                    final count = int.tryParse(text);
                    if (text.isEmpty || count == null || count <= 0) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('新增失敗！請輸入金額')),
                      );
                      return;
                    }

                    final newEntry = Entry(
                      category: _selectionIndex.toString(),
                      entryType: _isIncome ? 'income' : 'expend',
                      amount: int.tryParse(_amountCtrl.text) ?? 0,
                      note: _noteCtrl.text,
                      createdAt: DateTime.now(),
                    );

                    try {
                      entryProvider.addEntry(newEntry);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('新增成功！:)')),
                      );
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('新增失敗！:(')),
                      );
                    }
                  },
                ),
              ],
            ),

            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                      color: _selectionMainIcon
                          ? AppColors.lightMain
                          : AppColors.disIcon,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          appIcon((_selectionIndex ?? 5).toString()),
                          size: MediaQuery.of(context).size.width * 0.5,
                          color: _selectionMainIcon
                              ? AppColors.font
                              : AppColors.invist,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _amountCtrl,
              cursorColor: AppColors.main,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: "金額",
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              validator: (v) {
                final t = v?.trim() ?? '';
                final n = int.tryParse(t);
                if (t.isEmpty) return '請輸入金額';
                if (n == null || n <= 0) return '金額需為正整數';
                return null;
              },
            ),

            const SizedBox(height: 12),

            // 備註輸入
            TextFormField(
              controller: _noteCtrl,
              cursorColor: AppColors.main,
              decoration: const InputDecoration(
                labelText: "備註",
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.note),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final isSelected = _selectionIndex == index;
                    return Card(
                      color: isSelected ? AppColors.main : AppColors.disIcon,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          setState(() {
                            _selectionIndex = index;
                            _selectionMainIcon = true;
                          });
                          log("card tapped!");
                        },
                        child: Center(
                          child: Icon(
                            appIcon(index.toString()),
                            color:
                                isSelected ? AppColors.font : AppColors.invist,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
