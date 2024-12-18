import 'package:equatable/equatable.dart';

import 'calendar_class_schedule.dart';

class CalendarSubjectGroup extends Equatable {
  final String id;
  final String name;
  final String teacher;
  final String subjectName;
  final List<CalendarClassSchedule> hours;

  const CalendarSubjectGroup({
    required this.id,
    required this.name,
    required this.teacher,
    required this.subjectName,
    required this.hours,
  });

  @override
  List<Object?> get props => [id, name, teacher, hours, subjectName];
}
