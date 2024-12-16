import 'package:equatable/equatable.dart';

import 'calendar_career.dart';

class CalendarInfo extends Equatable {
  final String id;
  final List<CalendarCareer> careers;

  const CalendarInfo({
    required this.id,
    required this.careers,
  });

  @override
  List<Object?> get props => [id, careers];
}
