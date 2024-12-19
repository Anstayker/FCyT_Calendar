import 'package:equatable/equatable.dart';

class CalendarClassSchedule extends Equatable {
  final String day;
  final String startTime;
  final String endTime;
  final String extraDetails;
  final String classroom;

  const CalendarClassSchedule({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.extraDetails,
    required this.classroom,
  });

  @override
  List<Object?> get props => [day, startTime, endTime, extraDetails, classroom];
}
