import 'package:flutter/material.dart';

import '../../domain/entities/calendar_subject_group.dart';

class MobileCalendar extends StatefulWidget {
  const MobileCalendar({
    super.key,
    required this.subjectsData,
    required this.isHorizontal,
  });

  @override
  State<MobileCalendar> createState() => _MobileCalendarState();

  final List<CalendarSubjectGroup> subjectsData;
  final bool isHorizontal;
}

class _MobileCalendarState extends State<MobileCalendar> {
  final verticalSize = 100.0;

  //? Modify also in subject_group_list_tile.dart
  static const Map<String, Color> subjectColors = {
    'Inglés I': Colors.red,
    'Física General': Colors.green,
    'Álgebra I': Colors.orange,
    'Cálculo I': Colors.purple,
    'Introducción A La Programación': Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final List<String> hours = [
      '06:45',
      '08:15',
      '09:45',
      '11:15',
      '12:45',
      '14:15',
      '15:45',
      '17:15',
      '18:45',
      '20:15',
      '21:45'
    ];

    final List<String> days = ['L', 'M', 'X', 'J', 'V', 'S'];
    final List<String> daysFull = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado'
    ];

    return Column(
      children: [
        daysRow(widget.isHorizontal ? daysFull : days),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 250,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ...hours.map((hour) => hoursDisplay(hour)),
                      ],
                    ),
                    classScheduleTable(days, hours),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container hoursDisplay(String hour) {
    return Container(
      height: widget.isHorizontal ? verticalSize : verticalSize + 30,
      width: 60,
      alignment: Alignment.center,
      child: Text(hour),
    );
  }

  Widget classScheduleTable(List<String> days, List<String> hours) {
    Map<String, List<CalendarSubjectGroup>> scheduleMap = {};

    for (var subject in widget.subjectsData) {
      for (var schedule in subject.hours) {
        String key = '${schedule.day}-${schedule.startTime}';
        if (scheduleMap.containsKey(key)) {
          scheduleMap[key]!.add(subject);
        } else {
          scheduleMap[key] = [subject];
        }
      }
    }

    return Column(
      children: hours.map((hour) {
        return Row(
          children: days.map((day) {
            final key = '$day-$hour';
            final subjects = scheduleMap[key] ?? [];
            final hasConflict = subjects.length > 1;

            final selectedGroup = subjects.isNotEmpty
                ? subjects.first
                : const CalendarSubjectGroup(
                    id: '',
                    name: '',
                    teacher: '',
                    subjectName: '',
                    hours: [],
                  );

            String classroomName = '';
            if (selectedGroup.hours.isNotEmpty) {
              classroomName = selectedGroup.hours
                  .firstWhere(
                    (element) =>
                        element.day == day && element.startTime == hour,
                  )
                  .classroom;
            }

            if (hasConflict) {
              return conflictCell(subjects);
            } else {
              return normalCell(days, selectedGroup, classroomName);
            }
          }).toList(),
        );
      }).toList(),
    );
  }

  Container normalCell(List<String> days, CalendarSubjectGroup selectedGroup,
      String classroomName) {
    return Container(
      height: widget.isHorizontal ? verticalSize : verticalSize + 30,
      width: widget.isHorizontal
          ? (MediaQuery.of(context).size.width - (370)) / days.length
          : MediaQuery.of(context).size.width / days.length - 10,
      decoration: BoxDecoration(
        color: selectedGroup.name.isNotEmpty
            ? (subjectColors[selectedGroup.subjectName] ?? Colors.grey)
                .withOpacity(0.5)
            : null,
        border: Border.all(color: Colors.grey[350]!),
      ),
      child: selectedGroup.name.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedGroup.subjectName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: widget.isHorizontal ? 2 : 3,
                ),
                Text(
                  widget.isHorizontal
                      ? 'Grupo: ${selectedGroup.name}'
                      : 'G:${selectedGroup.name}',
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.isHorizontal ? 'Aula: $classroomName' : classroomName,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : null,
    );
  }

  Widget conflictCell(List<CalendarSubjectGroup> subjects) {
    return Container(
      height: widget.isHorizontal ? verticalSize : verticalSize + 30,
      width: widget.isHorizontal
          ? (MediaQuery.of(context).size.width - (370)) / 6
          : MediaQuery.of(context).size.width / 6 - 10,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: subjects.map((subject) {
          return Column(
            children: [
              Text(
                subject.subjectName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.isHorizontal
                    ? 'Grupo: ${subject.name}'
                    : 'G:${subject.name}',
                textAlign: TextAlign.center,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Row daysRow(List<String> days) {
    return Row(
      children: [
        const SizedBox(width: 60),
        ...days.map(
          (day) => Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
