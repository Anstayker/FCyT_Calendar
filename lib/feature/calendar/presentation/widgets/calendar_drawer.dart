import 'package:flutter/material.dart';

import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_semester.dart';
import '../../domain/entities/calendar_subject.dart';
import '../../domain/entities/calendar_subject_group.dart';

import 'mobile_calendar_widgets.dart';

class CalendarDrawer extends StatefulWidget {
  const CalendarDrawer({
    super.key,
    required this.careersList,
    required this.onCareerSelected,
    required this.onSemesterSelected,
    required this.onSubjectSelected,
    required this.onSubjectGroupSelected,
    required this.onBack,
    this.selectedCareer,
    this.selectedSemester,
    this.selectedSubject,
    this.selectedSubjectGroup,
  });

  final List<CalendarCareer> careersList;
  final CalendarCareer? selectedCareer;
  final CalendarSemester? selectedSemester;
  final CalendarSubject? selectedSubject;
  final CalendarSubjectGroup? selectedSubjectGroup;
  final Function(CalendarCareer) onCareerSelected;
  final Function(CalendarSemester) onSemesterSelected;
  final Function(CalendarSubject) onSubjectSelected;
  final Function(CalendarSubjectGroup) onSubjectGroupSelected;
  final VoidCallback onBack;

  @override
  State<CalendarDrawer> createState() => _CalendarDrawerState();
}

class _CalendarDrawerState extends State<CalendarDrawer> {
  Set<CalendarSemester> expandedSemesters = {};
  Set<CalendarSubject> expandedSubjects = {};

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
          else if (widget.selectedSemester == null)
            ...widget.selectedCareer!.semesters
                .map((semester) => SemesterListTile(
                      semester: semester,
                      onTap: () => widget.onSemesterSelected(semester),
                    ))
          else
            ...widget.selectedSemester!.subjects.expand((subject) {
              return [
                SubjectListTile(
                  subject: subject,
                  onTap: () {
                    setState(() {
                      if (expandedSubjects.contains(subject)) {
                        expandedSubjects.remove(subject);
                      } else {
                        expandedSubjects.add(subject);
                      }
                      widget.onSubjectSelected(subject);
                    });
                  },
                ),
                if (expandedSubjects.contains(subject))
                  ...subject.groups.map((subjectGroup) => SubjectGroupListTile(
                        subjectGroup: subjectGroup,
                        onTap: () =>
                            widget.onSubjectGroupSelected(subjectGroup),
                      ))
              ];
            }),
        ],
      ),
    );
  }

  Widget drawerCareerTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: widget.selectedCareer != null
                ? SizedBox(
                    width: 48,
                    child: IconButton(
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (expandedSemesters.isNotEmpty) {
                          setState(() {
                            expandedSemesters.clear();
                          });
                        } else {
                          widget.onBack();
                        }
                      },
                    ),
                  )
                : null,
          ),
          const Text('Carreras disponibles', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
