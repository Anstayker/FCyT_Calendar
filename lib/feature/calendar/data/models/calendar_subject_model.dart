import 'dart:convert';

import '../../domain/entities/calendar_subject.dart';

import 'calendar_subject_group_model.dart';

List<CalendarSubjectModel> calendarSubjectModelFromJson(String str) =>
    List<CalendarSubjectModel>.from(
        json.decode(str).map((x) => CalendarSubjectModel.fromJson(x)));

String calendarSubjectModelToJson(List<CalendarSubjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarSubjectModel extends CalendarSubject {
  const CalendarSubjectModel({
    required super.id,
    required super.name,
    required super.groups,
  });

  factory CalendarSubjectModel.fromJson(Map<String, dynamic> json) {
    return CalendarSubjectModel(
      id: json['id'],
      name: json['name'],
      groups: List<CalendarSubjectGroupModel>.from(
          json['groups'].map((x) => CalendarSubjectGroupModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'groups':
          groups.map((e) => (e as CalendarSubjectGroupModel).toJson()).toList(),
    };
  }
}
