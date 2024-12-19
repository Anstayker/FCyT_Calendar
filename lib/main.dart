import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/themes/default_theme.dart';
import 'feature/calendar/presentation/pages/calendar_page.dart';
import 'injection_container.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      theme: defaultTheme(),
      home: const CalendarPage(),
      title: 'Cappuchino UMSS',
    );
  }
}
