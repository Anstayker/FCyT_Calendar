import 'package:equatable/equatable.dart';

import 'calendar_subject.dart';

class CalendarSemester extends Equatable {
  final List<CalendarSubject> subjects;
  final String semester;

  const CalendarSemester({
    required this.subjects,
    required this.semester,
  });

  @override
  List<Object?> get props => [subjects, semester];
}
