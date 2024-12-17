import 'package:flutter/material.dart';

import '../../domain/entities/calendar_subject.dart';

class SubjectListTile extends StatelessWidget {
  final CalendarSubject subject;
  final VoidCallback onTap;

  const SubjectListTile({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subject.name),
      onTap: onTap,
    );
  }
}
