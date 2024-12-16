import 'dart:convert';

import '../../domain/entities/calendar_semester.dart';

import 'calendar_subject_model.dart';

List<CalendarSemesterModel> calendarSemesterModelFromJson(String str) =>
    List<CalendarSemesterModel>.from(
        json.decode(str).map((x) => CalendarSemesterModel.fromJson(x)));

String calendarSemesterModelToJson(List<CalendarSemesterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarSemesterModel extends CalendarSemester {
  const CalendarSemesterModel({
    required super.name,
    required super.subjects,
  });

  factory CalendarSemesterModel.fromJson(Map<String, dynamic> json) {
    return CalendarSemesterModel(
      name: json['name'],
      subjects: List<CalendarSubjectModel>.from(
          json['subjects'].map((x) => CalendarSubjectModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subjects':
          subjects.map((e) => (e as CalendarSubjectModel).toJson()).toList(),
    };
  }
}
