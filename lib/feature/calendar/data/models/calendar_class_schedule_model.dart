import 'dart:convert';

import '../../domain/entities/calendar_class_schedule.dart';

List<CalendarClassScheduleModel> calendarClassScheduleModelFromJson(
        String str) =>
    List<CalendarClassScheduleModel>.from(
        json.decode(str).map((x) => CalendarClassScheduleModel.fromJson(x)));

String calendarClassScheduleModelToJson(
        List<CalendarClassScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarClassScheduleModel extends CalendarClassSchedule {
  const CalendarClassScheduleModel({
    required super.day,
    required super.startTime,
    required super.endTime,
    required super.extraDetails,
    required super.classroom,
  });

  factory CalendarClassScheduleModel.fromJson(Map<String, dynamic> json) {
    return CalendarClassScheduleModel(
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      extraDetails: json['extra_details'],
      classroom: json['classroom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'extra_details': extraDetails,
      'classroom': classroom,
    };
  }
}
