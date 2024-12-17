import 'package:cappuchino_prototype/feature/calendar/domain/entities/calendar_subject.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calendar_repository.dart';

class SetSubjectInCalendar implements UseCase<List<CalendarSubject>, Params> {
  final CalendarRepository repository;

  SetSubjectInCalendar({required this.repository});

  @override
  Future<Either<Failure, List<CalendarSubject>>> call(Params params) async {
    return await repository.setSubjectInCalendar(params.calendarSubjectId);
  }
}

class Params extends Equatable {
  final CalendarSubject calendarSubjectId;

  const Params({required this.calendarSubjectId});

  @override
  List<Object?> get props => [calendarSubjectId];
}
