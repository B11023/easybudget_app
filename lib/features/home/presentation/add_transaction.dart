import 'dart:developer';

import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:easybudget_app/common/theme/app_icon.dart';
import 'package:easybudget_app/common/widgets/select_card.dart';
import 'package:flutter/material.dart';

//state manage setState 很爛 要修 我想睡了 交給以後的我

class AddTransactionWidget extends StatefulWidget {
  const AddTransactionWidget({super.key});
  @override
  State<AddTransactionWidget> createState() => _AddTransactionWidget();
}

class _AddTransactionWidget extends State<AddTransactionWidget> {
  bool _isIncome = false;
  int? _selectionIndex;
  bool _selectionMainIcon = false;

  @override
  Widget build(BuildContext context) {
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
            // 標題列
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon:  Icon(Icons.close,color: AppColors.font,),
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
                  icon:  Icon(
                    Icons.send,
                    color: AppColors.font,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    log('send transaction');
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Card(
                  color: _selectionMainIcon
                      ? AppColors.lightMain
                      : AppColors.disIcon,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                        appIcon(_selectionIndex ?? 5),
                        size: MediaQuery.of(context).size.width * 0.5,
                        color: _selectionMainIcon
                            ? AppColors.font
                            : AppColors.invist,
                      )),
                ),
              ),
            ),
            TextField(
              cursorColor: AppColors.main,
              decoration: const InputDecoration(
                labelText: "金額",
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            // 備註輸入
            TextField(
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
                      color: isSelected
                          ? AppColors.main
                          : AppColors.disIcon,
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
                            appIcon(index),
                            color: isSelected
                                ? AppColors.font
                                : AppColors.invist,
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
