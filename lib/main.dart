import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'feature/calendar/presentation/pages/calendar_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dependencies init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      //theme: defaultTheme(),
      home: CalendarPage(),
      title: 'Cappuchino UMSS',
    );
  }
}
