import 'package:equatable/equatable.dart';

import 'class_schedule.dart';

class CalendarSubject extends Equatable {
  final String id;
  final String name;
  final String teacher;
  final String classroom;
  final List<ClassSchedule> hours;

  const CalendarSubject({
    required this.id,
    required this.name,
    required this.teacher,
    required this.classroom,
    required this.hours,
  });

  @override
  List<Object?> get props => [id, name, teacher, classroom, hours];
}
