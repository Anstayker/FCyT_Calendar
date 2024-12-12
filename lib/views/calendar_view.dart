import 'package:flutter/material.dart';

import '../models/event.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final List<Event> events = [
      Event(day: 'L', startTime: '6:45', endTime: '7:30', title: 'Clase 1'),
      Event(day: 'V', startTime: '9:45', endTime: '10:30', title: 'Clase 2'),
      Event(day: 'S', startTime: '8:15', endTime: '9:00', title: 'Clase 3'),
    ];

    final List<String> hours = [
      '6:45',
      '7:30',
      '8:15',
      '9:00',
      '9:45',
      '10:30',
      '11:15',
      '12:00',
      '12:45',
      '13:30',
      '14:15',
      '15:00',
      '15:45',
      '16:30',
      '17:15',
      '18:00',
      '18:45',
      '19:30',
      '20:15',
      '21:00',
      '21:45'
    ];

    final List<String> days = ['L', 'M', 'M', 'J', 'V', 'S'];

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 60),
            ...days.map((day) => Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ...hours.map((hour) => Container(
                          height: 45,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(hour),
                        )),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        for (int i = 0; i < hours.length; i++)
                          Row(
                            children: List.generate(days.length, (index) {
                              final day = days[index];
                              final hour = hours[i];
                              final event = events.firstWhere(
                                (event) =>
                                    event.day == day && event.startTime == hour,
                                orElse: () => Event(
                                    day: '',
                                    startTime: '',
                                    endTime: '',
                                    title: ''),
                              );
                              return Container(
                                height: 45,
                                width:
                                    MediaQuery.of(context).size.width / 6 - 10,
                                decoration: BoxDecoration(
                                  color: event.title.isNotEmpty
                                      ? Colors.blue.withOpacity(0.5)
                                      : null,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: event.title.isNotEmpty
                                    ? Center(child: Text(event.title))
                                    : null,
                              );
                            }),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
