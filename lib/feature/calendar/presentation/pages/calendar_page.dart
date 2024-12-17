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
  List<CalendarSubject> subjectsData = [];
  List<CalendarCareer> careersInfo = [];

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
              careersInfo = state.calendarCareerList;
              return layoutBuilder(context, careersInfo, subjectsData);
            }
            if (state is CalendarSetSubjectInCalendar) {
              print('object');
            }

            return layoutBuilder(context, careersInfo, subjectsData);
          },
        ));
  }

  LayoutBuilder layoutBuilder(
      BuildContext context,
      List<CalendarCareer> careersList,
      List<CalendarSubject> selectedSubjects) {
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
                  child: calendarDrawer(careersList, context),
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
            drawer: calendarDrawer(careersList, context),
            floatingActionButton: mobileMainFab(),
          );
        }
      },
    );
  }

  CalendarDrawer calendarDrawer(
      List<CalendarCareer> careersList, BuildContext context) {
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
          // No sé por qué esto provoca que se deba apretar 2 veces
          // El botón de back para retroceder a la lista de carreras
          // selectedSemester = semester;
          selectedSubject = null;
        });
      },
      onSubjectSelected: (subject) {
        BlocProvider.of<CalendarBloc>(context)
            .add(CalendarSetSubjectInCalendar(calendarSubject: subject));
        setState(() {
          selectedSubject = subject;
        });
      },
      onBack: () {
        setState(() {
          if (selectedSubject != null) {
            selectedSubject = null;
          } else if (selectedSemester != null) {
            selectedSemester = null;
          } else if (selectedCareer != null) {
            selectedCareer = null;
          }
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
