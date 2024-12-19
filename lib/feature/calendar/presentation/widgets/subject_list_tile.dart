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
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        title: Text(
          '•  ${subject.name}',
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}
