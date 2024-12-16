import 'package:equatable/equatable.dart';

class ClassSchedule extends Equatable {
  final String day;
  final String startTime;
  final String endTime;
  final String extraDetails;

  const ClassSchedule({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.extraDetails,
  });

  @override
  List<Object?> get props => [day, startTime, endTime, extraDetails];
}
