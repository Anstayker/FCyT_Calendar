import 'package:flutter/material.dart';

import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_semester.dart';
import '../../domain/entities/calendar_subject.dart';
import 'mobile_calendar_widgets.dart';

class CalendarDrawer extends StatefulWidget {
  const CalendarDrawer({
    super.key,
    required this.careersList,
    required this.onCareerSelected,
    required this.onSemesterSelected,
    required this.onSubjectSelected,
    required this.onBack,
    this.selectedCareer,
    this.selectedSemester,
  });

  final List<CalendarCareer> careersList;
  final CalendarCareer? selectedCareer;
  final CalendarSemester? selectedSemester;
  final Function(CalendarCareer) onCareerSelected;
  final Function(CalendarSemester) onSemesterSelected;
  final Function(CalendarSubject) onSubjectSelected;
  final VoidCallback onBack;

  @override
  State<CalendarDrawer> createState() => _CalendarDrawerState();
}

class _CalendarDrawerState extends State<CalendarDrawer> {
  Set<CalendarSemester> expandedSemesters = {};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          drawerCareerTitle(),
          if (widget.selectedCareer == null)
            ...widget.careersList.map((career) => CareerListTile(
                  career: career,
                  onTap: () => widget.onCareerSelected(career),
                ))
          else ...[
            BackButton(onPressed: widget.onBack),
            ...widget.selectedCareer!.semesters.map((semester) => Column(
                  children: [
                    SemesterListTile(
                      semester: semester,
                      onTap: () {
                        setState(() {
                          if (expandedSemesters.contains(semester)) {
                            expandedSemesters.remove(semester);
                          } else {
                            expandedSemesters.add(semester);
                          }
                          widget.onSemesterSelected(semester);
                        });
                      },
                    ),
                    if (expandedSemesters.contains(semester))
                      ...semester.subjects.map((subject) => SubjectListTile(
                            subject: subject,
                            onTap: () => widget.onSubjectSelected(subject),
                          ))
                  ],
                ))
          ],
        ],
      ),
    );
  }

  Widget drawerCareerTitle() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Carreras disponibles', style: TextStyle(fontSize: 20)),
    );
  }
}
