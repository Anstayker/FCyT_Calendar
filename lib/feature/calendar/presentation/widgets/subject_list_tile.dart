import 'package:flutter/material.dart';

import '../../domain/entities/calendar_subject.dart';

class SubjectListTile extends StatefulWidget {
  final CalendarSubject subject;
  final VoidCallback onTap;

  const SubjectListTile({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  State<SubjectListTile> createState() => _SubjectListTileState();
}

class _SubjectListTileState extends State<SubjectListTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: ListTile(
        title: Text(widget.subject.name),
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
