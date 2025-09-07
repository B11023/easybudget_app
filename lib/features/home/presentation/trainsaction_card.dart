import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TrainsactionCard extends StatelessWidget {
  final String label;        
  final int itemCount;      
  final List<IconData> icons; 
  final List<String> titles;  
  final List<String> trailing; 

  const TrainsactionCard({
    super.key,
    required this.label,
    required this.itemCount,
    required this.icons,
    required this.titles,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
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
              itemCount: itemCount,
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
                    leading: Icon(icons[index]),
                    title: Text(titles[index]),
                    trailing: Text(trailing[index]),
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
  }
}
