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
    required this.selectedGroups,
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
  final Set<CalendarSubjectGroup> selectedGroups;
  final VoidCallback onBack;

  @override
  State<CalendarDrawer> createState() => _CalendarDrawerState();
}

class _CalendarDrawerState extends State<CalendarDrawer> {
  Set<CalendarSemester> expandedSemesters = {};
  Set<CalendarSubject> expandedSubjects = {};
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          drawerCareerTitle(),
          if (widget.selectedCareer != null) searchField(),
          if (widget.selectedCareer == null)
            ...widget.careersList.map((career) => CareerListTile(
                  career: career,
                  onTap: () => widget.onCareerSelected(career),
                ))
          else
            ...widget.selectedCareer!.semesters.expand((semester) {
              bool shouldExpandSemester = searchQuery.isNotEmpty &&
                  semester.subjects.any((subject) {
                    return subject.name
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        subject.groups.any((group) => group.teacher
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()));
                  });

              if (shouldExpandSemester) {
                expandedSemesters.add(semester);
              }

              return [
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
                  ...semester.subjects.expand((subject) {
                    bool shouldExpandSubject = searchQuery.isNotEmpty &&
                        (subject.name
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()) ||
                            subject.groups.any((group) => group.teacher
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase())));

                    if (shouldExpandSubject) {
                      expandedSubjects.add(subject);
                    }

                    return [
                      if (searchQuery.isEmpty || shouldExpandSubject)
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
                        ...subject.groups
                            .map((subjectGroup) => SubjectGroupListTile(
                                  subjectGroup: subjectGroup,
                                  isSelected: widget.selectedGroups
                                      .contains(subjectGroup),
                                  onTap: () {
                                    widget.onSubjectGroupSelected(subjectGroup);
                                  },
                                ))
                    ];
                  })
              ];
            }),
        ],
      ),
    );
  }

  Widget drawerCareerTitle() {
    String title;

    if (widget.selectedCareer == null) {
      title = 'Carreras Disponibles';
    } else {
      title = 'Seleccionar Materias';
    }
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
          Text(title, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Buscar materias o docentes',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
            expandedSemesters.clear();
            expandedSubjects.clear();
          });
        },
      ),
    );
  }
}
