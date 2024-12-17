import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/error/failures.dart';
import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_subject.dart';
import '../models/calendar_career_model.dart';

abstract class CalendarLocalDatasource {
  Future<List<CalendarCareer>> getAllCalendarInfo();
  Future<List<CalendarSubject>> setSubjectInCalendar(
      CalendarSubject calendarSubject);
}

class CalendarLocalDatasourceImpl implements CalendarLocalDatasource {
  final Set<CalendarSubject> _cache = {};

  @override
  Future<List<CalendarCareer>> getAllCalendarInfo() async {
    try {
      final result = await rootBundle.loadString('assets/calendar_info.json');
      final Map<String, dynamic> jsonData = json.decode(result);
      final List<dynamic> careersData = jsonData['careers'];
      return careersData.map((e) => CalendarCareerModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<CalendarSubject>> setSubjectInCalendar(
      CalendarSubject calendarSubject) async {
    try {
      if (_cache.contains(calendarSubject)) {
        _cache.remove(calendarSubject);
      } else {
        _cache.add(calendarSubject);
      }
      return _cache.toList();
    } catch (e) {
      throw CacheFailure();
    }
  }
}
