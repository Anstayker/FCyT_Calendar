import 'package:flutter/material.dart';

import '../../domain/entities/calendar_subject_group.dart';

class SubjectGroupListTile extends StatefulWidget {
  final CalendarSubjectGroup subjectGroup;
  final VoidCallback onTap;

  const SubjectGroupListTile({
    super.key,
    required this.subjectGroup,
    required this.onTap,
  });

  @override
  State<SubjectGroupListTile> createState() => _SubjectGroupListTileState();
}

class _SubjectGroupListTileState extends State<SubjectGroupListTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: ListTile(
        title: Text(widget.subjectGroup.name),
        trailing: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onTap();
          },
        ),
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
          widget.onTap();
        },
      ),
    );
  }
}
