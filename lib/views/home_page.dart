import 'package:flutter/material.dart';

import 'mobile_version_view.dart';
import 'web_version_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return const WebVersionView();
        } else {
          return MobileVersionView(context: context);
        }
      },
    );
  }
}
