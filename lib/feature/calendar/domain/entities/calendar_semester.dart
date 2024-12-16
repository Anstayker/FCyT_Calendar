import 'package:equatable/equatable.dart';

import 'calendar_subject.dart';

class CalendarSemester extends Equatable {
  final String name;
  final List<CalendarSubject> subjects;

  const CalendarSemester({
    required this.name,
    required this.subjects,
  });

  @override
  List<Object?> get props => [subjects, name];
}
