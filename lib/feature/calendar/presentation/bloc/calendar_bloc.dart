import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/calendar_career.dart';
import '../../domain/usecases/get_all_calendar_info.dart' as get_all_info;

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final get_all_info.GetAllCalendarInfo getAllCalendarInfo;

  CalendarBloc({
    required this.getAllCalendarInfo,
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
  }
}
