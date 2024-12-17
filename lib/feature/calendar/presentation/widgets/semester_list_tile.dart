import 'package:flutter/material.dart';

import '../../domain/entities/calendar_semester.dart';

class SemesterListTile extends StatelessWidget {
  final CalendarSemester semester;
  final VoidCallback onTap;

  const SemesterListTile({
    Key? key,
    required this.semester,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(semester.name),
      onTap: onTap,
    );
  }
}