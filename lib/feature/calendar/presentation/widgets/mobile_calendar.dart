import 'package:flutter/material.dart';

class MobileCalendar extends StatelessWidget {
  const MobileCalendar({
    super.key,
  });

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

    // ignore: unused_local_variable
    final List<ClassSchedule> classScheduleList = [];

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
                classScheduleTable(scrollController, hours, days, context)
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

  Expanded classScheduleTable(ScrollController scrollController,
      List<String> hours, List<String> days, BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          for (int i = 0; i < hours.length; i++)
            Row(
              children: List.generate(days.length, (index) {
                // ignore: unused_local_variable
                final day = days[index];
                // ignore: unused_local_variable
                final hour = hours[i];
                // TODO: add class schedule

                return Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 6 - 10,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[350]!),
                  ),
                );
              }),
            )
        ],
      ),
    ));
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

class ClassSchedule {
  final String day;
  final String startTime;
  final String endTime;
  final String title;

  ClassSchedule({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.title,
  });
}
