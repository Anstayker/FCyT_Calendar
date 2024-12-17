import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/calendar_subject_group.dart';
import '../repositories/calendar_repository.dart';

class SetSubjectInCalendar
    implements UseCase<List<CalendarSubjectGroup>, Params> {
  final CalendarRepository repository;

  SetSubjectInCalendar({required this.repository});

  @override
  Future<Either<Failure, List<CalendarSubjectGroup>>> call(
      Params params) async {
    return await repository.setSubjectInCalendar(params.calendarSubjectId);
  }
}

class Params extends Equatable {
  final CalendarSubjectGroup calendarSubjectId;

  const Params({required this.calendarSubjectId});

  @override
  List<Object?> get props => [calendarSubjectId];
}
