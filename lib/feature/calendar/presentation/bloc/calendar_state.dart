part of 'calendar_bloc.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

final class CalendarInitial extends CalendarState {}

final class CalendarError extends CalendarState {
  final String message;

  const CalendarError(this.message);

  @override
  List<Object> get props => [message];
}

final class CalendarGetAllCalendarInfoLoading extends CalendarState {}

final class CalendarGetAllCalendarInfoLoaded extends CalendarState {
  final List<CalendarCareer> calendarCareerList;

  const CalendarGetAllCalendarInfoLoaded({required this.calendarCareerList});

  @override
  List<Object> get props => [calendarCareerList];
}

final class CalendarSetSubjectInCalendarLoading extends CalendarState {}

final class CalendarSetSubjectInCalendarLoaded extends CalendarState {}
