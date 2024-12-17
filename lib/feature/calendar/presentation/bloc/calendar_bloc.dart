import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_subject.dart';
import '../../domain/usecases/get_all_calendar_info.dart' as get_all_info;
import '../../domain/usecases/set_subject_in_calendar.dart'
    as set_subject_in_calendar;

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final get_all_info.GetAllCalendarInfo getAllCalendarInfo;
  final set_subject_in_calendar.SetSubjectInCalendar setSubjectInCalendar;

  CalendarBloc({
    required this.getAllCalendarInfo,
    required this.setSubjectInCalendar,
  }) : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) {});

    on<CalendarGetAllCalendarInfoEvent>((event, emit) async {
      emit(CalendarGetAllCalendarInfoLoading());
      final result = await getAllCalendarInfo.call(NoParams());
      result.fold(
        (failure) => emit(const CalendarError('Error while loading data')),
        (calendarCareer) => emit(CalendarGetAllCalendarInfoLoaded(
            calendarCareerList: calendarCareer)),
      );
    });
    on<CalendarSetSubjectInCalendar>((event, emit) async {
      emit(CalendarSetSubjectInCalendarLoading());
      final result = await setSubjectInCalendar.call(
          set_subject_in_calendar.Params(
              calendarSubjectId: event.calendarSubject));
      result.fold(
        (failure) => emit(const CalendarError('Error while loading data')),
        (calendarSubject) => emit(CalendarSetSubjectInCalendarSuccess(
            calendarSubject: calendarSubject)),
      );
    });
  }
}
