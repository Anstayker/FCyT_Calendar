import 'package:flutter/material.dart';

import '../../domain/entities/calendar_subject.dart';

class MobileCalendar extends StatefulWidget {
  const MobileCalendar({
    super.key,
    required this.subjectsData,
  });

  @override
  State<MobileCalendar> createState() => _MobileCalendarState();

  final List<CalendarSubject> subjectsData;
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

    final List<String> days = ['L', 'M', 'M', 'J', 'V', 'S'];

    return Column(
      children: [
        daysRow(days),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ...hours.map((hour) => hoursDisplay(hour)),
                  ],
                ),
                classScheduleTable(days, hours)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container hoursDisplay(String hour) {
    return Container(
      height: 45,
      width: 60,
      alignment: Alignment.center,
      child: Text(hour),
    );
  }

  Widget classScheduleTable(List<String> days, List<String> hours) {
    return Column(
      children: hours.asMap().entries.map((entry) {
        String hour = entry.value;
        return Row(
          children: days.asMap().entries.map((dayEntry) {
            String day = dayEntry.value;
            final selectedClass = widget.subjectsData.firstWhere(
              (element) => element.hours.any(
                (schedule) {
                  return schedule.day == day && schedule.startTime == hour;
                },
              ),
              orElse: () => const CalendarSubject(
                id: '',
                name: '',
                teacher: '',
                hours: [],
              ),
            );

            return Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 6 - 10,
              decoration: BoxDecoration(
                color: selectedClass.name.isNotEmpty
                    ? Colors.blue.withOpacity(0.5)
                    : null,
                border: Border.all(color: Colors.grey[350]!),
              ),
              child: selectedClass.name.isNotEmpty
                  ? Center(child: Text(selectedClass.name))
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
