import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_subject.dart';
import '../../domain/entities/calendar_subject_group.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../datasources/calendar_local_datasource.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarLocalDatasource calendarLocalDatasource;

  CalendarRepositoryImpl({required this.calendarLocalDatasource});

  @override
  Future<Either<Failure, List<CalendarCareer>>> getAllCalendarInfo() async {
    try {
      final calendarCarreerList =
          await calendarLocalDatasource.getAllCalendarInfo();
      return Right(calendarCarreerList);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CalendarSubjectGroup>>> setSubjectInCalendar(
      CalendarSubjectGroup calendarSubjectId) async {
    try {
      final result =
          await calendarLocalDatasource.setSubjectInCalendar(calendarSubjectId);
      return Right(result);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCalendarFromCache() async {
    // TODO: implement getCalendarFromCache
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> removeCalendarInCache(String calendarId) {
    // TODO: implement removeCalendarInCache
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> removeSubjectInCalendar(
      CalendarSubject calendarSubjectId) {
    // TODO: implement removeSubjectInCalendar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> saveCalendarInCache(
      List<CalendarSubject> calendarSubjects) {
    // TODO: implement saveCalendarInCache
    throw UnimplementedError();
  }
}
