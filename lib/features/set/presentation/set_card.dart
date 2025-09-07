import 'package:easybudget_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

class SetCard extends StatelessWidget {
  final int index;

  const SetCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return mySetCard(index, context);
  }

  Widget mySetCard(int index, BuildContext context) {
    switch (index) {
      case 0:
        return Card(
          color: AppColors.main,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              log("Settings card tapped!");
            },
            child: Center(
              child: Icon(
                Icons.settings,
                color: AppColors.font,
                size: MediaQuery.of(context).size.width * 0.15,
              ),
            ),
          ),
        );

      case 1:
        //腸太郎
        return Card(
          clipBehavior: Clip.antiAlias,
          color: AppColors.main,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final uri =
                  Uri.parse('https://www.youtube.com/watch?v=h9VITcI0iYI');
              try {
                var ok = await launchUrl(
                  uri,
                  mode: LaunchMode.inAppBrowserView,
                  webViewConfiguration: const WebViewConfiguration(
                    enableJavaScript: true,
                    enableDomStorage: true,
                  ),
                );
                debugPrint('inAppWebView result: $ok');

                if (!ok) {
                  ok = await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                  debugPrint('externalApplication result: $ok');
                }
              } catch (e, st) {
                debugPrint('launch error: $e');
                debugPrintStack(stackTrace: st);
              }
            },
            child: Center(
              child: Image.asset(
                'assets/saugy.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
