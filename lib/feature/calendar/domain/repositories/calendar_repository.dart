import 'package:cappuchino_prototype/feature/calendar/domain/entities/calendar_subject.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/calendar_carreer.dart';

abstract class CalendarRepository {
  Future<Either<Failure, List<CalendarCarreer>>> getAllCalendarInfo();
  Future<Either<Failure, bool>> setSubjectInCalendar(String calendarSubjectId);
  Future<Either<Failure, bool>> removeSubjectInCalendar(
      String calendarSubjectId);
  Future<Either<Failure, bool>> saveCalendarInCache(
      List<CalendarSubject> calendarSubjects);
  Future<Either<Failure, bool>> removeCalendarInCache(String calendarId);
  Future<Either<Failure, List<String>>> getCalendarFromCache();
}
