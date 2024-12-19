import 'package:equatable/equatable.dart';

import 'calendar_subject_group.dart';

class CalendarSubject extends Equatable {
  final String id;
  final String name;
  final List<CalendarSubjectGroup> groups;

  const CalendarSubject({
    required this.id,
    required this.name,
    required this.groups,
  });

  @override
  List<Object?> get props => [id, name, groups];
}
