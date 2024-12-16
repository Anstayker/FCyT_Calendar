import 'dart:convert';

import '../../domain/entities/calendar_career.dart';

import 'calendar_semester_model.dart';

List<CalendarCareerModel> calendarCareerModelFromJson(String str) =>
    List<CalendarCareerModel>.from(
        json.decode(str).map((x) => CalendarCareerModel.fromJson(x)));

String calendarCareerModelToJson(List<CalendarCareerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarCareerModel extends CalendarCareer {
  const CalendarCareerModel({
    required super.name,
    required super.semesters,
  });

  factory CalendarCareerModel.fromJson(Map<String, dynamic> json) {
    return CalendarCareerModel(
      name: json['name'],
      semesters: List<CalendarSemesterModel>.from(
          json['semesters'].map((x) => CalendarSemesterModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'semesters':
          semesters.map((e) => (e as CalendarSemesterModel).toJson()).toList(),
    };
  }
}
