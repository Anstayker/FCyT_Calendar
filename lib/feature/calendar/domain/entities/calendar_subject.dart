import 'package:equatable/equatable.dart';

import 'calendar_class_schedule.dart';

class CalendarSubject extends Equatable {
  final String id;
  final String name;
  final String teacher;
  final List<CalendarClassSchedule> hours;

  const CalendarSubject({
    required this.id,
    required this.name,
    required this.teacher,
    required this.hours,
  });

  @override
  List<Object?> get props => [id, name, teacher, hours];
}
