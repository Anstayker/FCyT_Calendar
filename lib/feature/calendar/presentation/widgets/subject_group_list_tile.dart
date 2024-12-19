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

  //? Modify also in mobile_calendar.dart
  static const Map<String, Color> subjectColors = {
    'Inglés I': Colors.red,
    'Física General': Colors.green,
    'Álgebra I': Colors.orange,
    'Cálculo I': Colors.purple,
    'Introducción a la Programación': Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ListTile(
        title: Text(subjectGroup.teacher),
        subtitle: Text('Grupo: ${subjectGroup.name}'),
        trailing: Checkbox(
          value: isSelected,
          activeColor: (subjectColors[subjectGroup.subjectName] ?? Colors.grey)
              .withOpacity(0.7),
          onChanged: (bool? value) {
            onTap();
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
