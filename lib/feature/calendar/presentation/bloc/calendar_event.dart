part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarGetAllCalendarInfoEvent extends CalendarEvent {}

class CalendarSetSubjectInCalendar extends CalendarEvent {
  final CalendarSubjectGroup calendarSubject;

  const CalendarSetSubjectInCalendar({required this.calendarSubject});

  @override
  List<Object> get props => [calendarSubject];
}
