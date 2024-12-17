import 'package:get_it/get_it.dart';

import 'feature/calendar/data/datasources/calendar_local_datasource.dart';
import 'feature/calendar/data/repositories/calendar_repository_impl.dart';
import 'feature/calendar/domain/repositories/calendar_repository.dart';
import 'feature/calendar/domain/usecases/get_all_calendar_info.dart';
import 'feature/calendar/domain/usecases/set_subject_in_calendar.dart';
import 'feature/calendar/presentation/bloc/calendar_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - Calendar
  // Bloc
  sl.registerFactory(
      () => CalendarBloc(getAllCalendarInfo: sl(), setSubjectInCalendar: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetAllCalendarInfo(repository: sl()));
  sl.registerLazySingleton(() => SetSubjectInCalendar(repository: sl()));

  // Repository
  sl.registerLazySingleton<CalendarRepository>(
      () => CalendarRepositoryImpl(calendarLocalDatasource: sl()));

  // Local Data Source
  sl.registerLazySingleton<CalendarLocalDatasource>(
      () => CalendarLocalDatasourceImpl());
}
