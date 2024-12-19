import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    useMaterial3: true,
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    appBarTheme: appBarTheme(),
    brightness: Brightness.dark,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    scrolledUnderElevation: 0.0,
  );
}
