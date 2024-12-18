import 'package:flutter/material.dart';
import '../../domain/entities/calendar_subject_group.dart';

class WebCalendar extends StatefulWidget {
  const WebCalendar({
    super.key,
    required this.subjectsData,
  });

  @override
  State<WebCalendar> createState() => _WebCalendarState();

  final List<CalendarSubjectGroup> subjectsData;
}

class _WebCalendarState extends State<WebCalendar> {
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey,
                    child: const Center(child: Text('Hora')),
                  ),
                  ...days
                      .map((day) => Container(
                            width: 100,
                            height: 60,
                            color: Colors.grey,
                            child: Center(child: Text(day)),
                          ))
                      .toList(),
                ],
              ),
              Column(
                children: hours.map((hour) {
                  return Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey,
                        child: Center(child: Text(hour)),
                      ),
                      ...days.map((day) {
                        final subjectGroup = widget.subjectsData.firstWhere(
                          (group) => group.hours.any((schedule) =>
                              schedule.day == day &&
                              schedule.startTime == hour),
                          orElse: () => CalendarSubjectGroup(
                            id: '',
                            name: '',
                            teacher: '',
                            hours: [],
                            subjectName: '',
                          ),
                        );
                        return Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: subjectGroup.name.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(subjectGroup.subjectName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(subjectGroup.name),
                                    Text(subjectGroup.teacher),
                                  ],
                                )
                              : null,
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
