import '../../domain/entities/calendar_career.dart';

abstract class CalendarLocalDatasource {
  Future<List<CalendarCareer>> getAllCalendarInfo();
}

class CalendarLocalDatasourceImpl implements CalendarLocalDatasource {
  @override
  Future<List<CalendarCareer>> getAllCalendarInfo() async {
    return [];
  }
}
