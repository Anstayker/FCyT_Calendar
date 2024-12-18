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
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final List<String> hours = [
      '6:45',
      '8:15',
      '9:45',
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
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: Text(hour),
    );
  }

  Widget classScheduleTable(List<String> days, List<String> hours) {
    return Column(
      children: hours.map((hour) {
        return Row(
          children: days.map((day) {
            final selectedGroup = widget.subjectsData.firstWhere(
              (element) => element.hours.any(
                (schedule) {
                  return schedule.day == day && schedule.startTime == hour;
                },
              ),
              orElse: () => const CalendarSubjectGroup(
                id: '',
                name: '',
                teacher: '',
                subjectName: '',
                hours: [],
              ),
            );

            return Container(
              height: 60,
              width: widget.isHorizontal
                  ? (MediaQuery.of(context).size.width - (370)) / days.length
                  : MediaQuery.of(context).size.width / days.length - 10,
              decoration: BoxDecoration(
                color: selectedGroup.name.isNotEmpty
                    ? Colors.blue.withOpacity(0.5)
                    : null,
                border: Border.all(color: Colors.grey[350]!),
              ),
              child: selectedGroup.name.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedGroup.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          selectedGroup.id,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : null,
            );
          }).toList(),
        );
      }).toList(),
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
