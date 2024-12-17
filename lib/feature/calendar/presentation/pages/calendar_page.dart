import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_semester.dart';
import '../../domain/entities/calendar_subject.dart';
import '../bloc/calendar_bloc.dart';
import '../widgets/mobile_calendar_widgets.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarCareer? selectedCareer;
  CalendarSemester? selectedSemester;
  CalendarSubject? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<CalendarBloc>(),
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is CalendarInitial) {
              BlocProvider.of<CalendarBloc>(context)
                  .add(CalendarGetAllCalendarInfoEvent());
            }
            if (state is CalendarGetAllCalendarInfoLoaded) {
              return layoutBuilder(state.calendarCareerList);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  LayoutBuilder layoutBuilder(List<CalendarCareer> careersList) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // TODO: Revisar el maxWidth
        if (constraints.maxWidth > 800) {
          // ! Web Version
          return Scaffold(
            appBar: calendarAppBar(),
            body: Row(
              children: [
                SizedBox(
                  width: 250,
                  child: calendarDrawer(careersList),
                ),
                Expanded(child: buildBody()),
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // ! Mobile Version
          return Scaffold(
            appBar: calendarAppBar(),
            body: buildBody(),
            drawer: calendarDrawer(careersList),
            floatingActionButton: mobileMainFab(),
          );
        }
      },
    );
  }

  CalendarDrawer calendarDrawer(List<CalendarCareer> careersList) {
    return CalendarDrawer(
      careersList: careersList,
      onCareerSelected: (career) {
        setState(() {
          selectedCareer = career;
          selectedSemester = null;
          selectedSubject = null;
        });
      },
      onSemesterSelected: (semester) {
        setState(() {
          selectedSemester = semester;
          selectedSubject = null;
        });
      },
      onSubjectSelected: (subject) {
        setState(() {
          selectedSubject = subject;
        });
      },
      selectedCareer: selectedCareer,
      selectedSemester: selectedSemester,
    );
  }

  Widget buildBody() {
    return const MobileCalendar();
  }

  FloatingActionButton mobileMainFab() {
    return FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add));
  }

  AppBar calendarAppBar() {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.coffee),
          SizedBox(width: 20),
          Text('Cappuchino UMSS'),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }
}
