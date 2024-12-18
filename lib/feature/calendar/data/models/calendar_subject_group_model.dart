import 'dart:convert';

import '../../domain/entities/calendar_subject_group.dart';

import 'calendar_class_schedule_model.dart';

// TODO: needs fix
List<CalendarSubjectGroupModel> calendarSubjectGroupModelFromJson(String str) =>
    List<CalendarSubjectGroupModel>.from(
        json.decode(str).map((x) => CalendarSubjectGroupModel.fromJson(x, '')));

String calendarSubjectGroupModelToJson(List<CalendarSubjectGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarSubjectGroupModel extends CalendarSubjectGroup {
  const CalendarSubjectGroupModel({
    required super.id,
    required super.name,
    required super.teacher,
    required super.hours,
    required super.subjectName,
  });

  factory CalendarSubjectGroupModel.fromJson(
      Map<String, dynamic> json, String subjectName) {
    return CalendarSubjectGroupModel(
      id: json['id'],
      name: json['name'],
      teacher: json['teacher'],
      subjectName: subjectName,
      hours: List<CalendarClassScheduleModel>.from(
          json['hours'].map((x) => CalendarClassScheduleModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teacher': teacher,
      'subject_name': subjectName,
      'hours':
          hours.map((e) => (e as CalendarClassScheduleModel).toJson()).toList(),
    };
  }
}
