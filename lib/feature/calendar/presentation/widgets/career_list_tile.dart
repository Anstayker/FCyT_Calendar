import 'package:flutter/material.dart';

import '../../domain/entities/calendar_career.dart';

class CareerListTile extends StatelessWidget {
  const CareerListTile({
    super.key,
    required this.career,
    required this.onTap,
  });

  final CalendarCareer career;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(career.name),
      onTap: onTap,
    );
  }
}
