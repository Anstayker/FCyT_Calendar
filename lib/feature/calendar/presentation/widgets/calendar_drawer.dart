import 'package:flutter/material.dart';

import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_semester.dart';
import '../../domain/entities/calendar_subject.dart';
import 'mobile_calendar_widgets.dart';

class CalendarDrawer extends StatelessWidget {
  const CalendarDrawer({
    super.key,
    required this.careersList,
    required this.onCareerSelected,
    required this.onSemesterSelected,
    required this.onSubjectSelected,
    this.selectedCareer,
    this.selectedSemester,
  });

  final List<CalendarCareer> careersList;
  final CalendarCareer? selectedCareer;
  final CalendarSemester? selectedSemester;
  final Function(CalendarCareer) onCareerSelected;
  final Function(CalendarSemester) onSemesterSelected;
  final Function(CalendarSubject) onSubjectSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          drawerCareerTitle(),
          if (selectedCareer == null)
            ...careersList.map((career) => CareerListTile(
                  career: career,
                  onTap: () => onCareerSelected(career),
                ))
          else if (selectedSemester == null)
            ...selectedCareer!.semesters.map((semester) => SemesterListTile(
                  semester: semester,
                  onTap: () => onSemesterSelected(semester),
                ))
          else
            ...selectedSemester!.subjects.map((subject) => SubjectListTile(
                  subject: subject,
                  onTap: () => onSubjectSelected(subject),
                )),
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
