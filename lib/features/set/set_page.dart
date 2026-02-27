import 'package:easybudget_app/common/widgets/base_scaffold.dart';
import 'package:easybudget_app/features/set/set_card.dart';
import 'package:flutter/material.dart';

class SetPage extends StatelessWidget {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 3,
      body: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '更多',
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return SetCard(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
