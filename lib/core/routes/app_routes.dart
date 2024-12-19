import 'package:flutter/material.dart';

import '../../feature/calendar/presentation/pages/calendar_page.dart';
import '../../views/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String calendar = '/calendar';

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _materialRoute(const HomePage());
      case calendar:
        return _materialRoute(const CalendarPage());
      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
