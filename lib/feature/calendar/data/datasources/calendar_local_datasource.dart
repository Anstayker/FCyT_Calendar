import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../domain/entities/calendar_career.dart';
import '../models/calendar_career_model.dart';

abstract class CalendarLocalDatasource {
  Future<List<CalendarCareer>> getAllCalendarInfo();
}

class CalendarLocalDatasourceImpl implements CalendarLocalDatasource {
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
}
