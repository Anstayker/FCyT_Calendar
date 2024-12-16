import 'package:equatable/equatable.dart';

import 'calendar_semester.dart';

class CalendarCarreer extends Equatable {
  final String name;
  final List<CalendarSemester> semesters;

  const CalendarCarreer({
    required this.name,
    required this.semesters,
  });

  @override
  List<Object?> get props => [name, semesters];
}
