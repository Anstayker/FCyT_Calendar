import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/calendar_career.dart';
import '../entities/calendar_subject.dart';

abstract class CalendarRepository {
  Future<Either<Failure, List<CalendarCareer>>> getAllCalendarInfo();
  Future<Either<Failure, List<CalendarSubject>>> setSubjectInCalendar(
      CalendarSubject calendarSubject);
  Future<Either<Failure, List<String>>> getCalendarFromCache();
  Future<Either<Failure, bool>> removeSubjectInCalendar(
      CalendarSubject calendarSubject);
  Future<Either<Failure, bool>> saveCalendarInCache(
      List<CalendarSubject> calendarSubjects);
  Future<Either<Failure, bool>> removeCalendarInCache(String calendarId);
}
