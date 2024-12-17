import 'package:flutter/material.dart';

import '../../domain/entities/calendar_subject_group.dart';

class SubjectGroupListTile extends StatelessWidget {
  final CalendarSubjectGroup subjectGroup;
  final bool isSelected;
  final VoidCallback onTap;

  const SubjectGroupListTile({
    super.key,
    required this.subjectGroup,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ListTile(
        title: Text(subjectGroup.teacher),
        subtitle: Text(subjectGroup.name),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (bool? value) {
            onTap();
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
