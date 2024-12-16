import 'dart:convert';

import '../../domain/entities/calendar_subject.dart';

import 'calendar_class_schedule_model.dart';

List<CalendarSubjectModel> calendarSubjectModelFromJson(String str) =>
    List<CalendarSubjectModel>.from(
        json.decode(str).map((x) => CalendarSubjectModel.fromJson(x)));

String calendarSubjectModelToJson(List<CalendarSubjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarSubjectModel extends CalendarSubject {
  const CalendarSubjectModel({
    required super.id,
    required super.name,
    required super.teacher,
    required super.hours,
  });

  factory CalendarSubjectModel.fromJson(Map<String, dynamic> json) {
    return CalendarSubjectModel(
      id: json['id'],
      name: json['name'],
      teacher: json['teacher'],
      hours: List<CalendarClassScheduleModel>.from(json['class_hours']
          .map((x) => CalendarClassScheduleModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teacher': teacher,
      'class_hours':
          hours.map((e) => (e as CalendarClassScheduleModel).toJson()).toList(),
    };
  }
}
