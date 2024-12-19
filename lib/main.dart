import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/themes/theme_notifier.dart';
import 'feature/calendar/presentation/pages/calendar_page.dart';
import 'injection_container.dart' as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          theme: themeNotifier.currentTheme,
          home: const CalendarPage(),
          title: 'Cappuchino UMSS',
        );
      },
    );
  }
}
