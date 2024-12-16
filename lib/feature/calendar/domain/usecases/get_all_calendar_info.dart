import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/calendar_career.dart';
import '../repositories/calendar_repository.dart';

class GetAllCalendarInfo implements UseCase<List<CalendarCareer>, NoParams> {
  final CalendarRepository repository;

  GetAllCalendarInfo({required this.repository});

  @override
  Future<Either<Failure, List<CalendarCareer>>> call(NoParams params) async {
    return await repository.getAllCalendarInfo();
  }
}
