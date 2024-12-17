import 'package:cappuchino_prototype/feature/calendar/domain/entities/calendar_subject_group.dart';
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
  CalendarSubjectGroup? selectedSubjectGroup;
  List<CalendarSubjectGroup> subjectsData = [];
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
            if (state is CalendarSetSubjectInCalendarSuccess) {
              subjectsData = state.calendarSubject;
              return layoutBuilder(context, careersInfo, subjectsData);
            }

            return layoutBuilder(context, careersInfo, subjectsData);
          },
        ));
  }

  LayoutBuilder layoutBuilder(
      BuildContext context,
      List<CalendarCareer> careersList,
      List<CalendarSubjectGroup> selectedSubjects) {
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
                Expanded(child: buildBody(subjectsData)),
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
            body: buildBody(subjectsData),
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
          selectedSubjectGroup = null;
        });
      },
      onSemesterSelected: (semester) {
        setState(() {
          selectedSemester = semester;
          selectedSubject = null;
          selectedSubjectGroup = null;
        });
      },
      onSubjectSelected: (subject) {
        setState(() {
          // selectedSubject = subject;
          selectedSubjectGroup = null;
        });
      },
      onSubjectGroupSelected: (subjectGroup) {
        setState(() {
          // selectedSubjectGroup = subjectGroup;
          BlocProvider.of<CalendarBloc>(context)
              .add(CalendarSetSubjectInCalendar(calendarSubject: subjectGroup));
        });
      },
      onBack: () {
        setState(() {
          if (selectedSubjectGroup != null) {
            selectedSubjectGroup = null;
          } else if (selectedSubject != null) {
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
      selectedSubject: selectedSubject,
      selectedSubjectGroup: selectedSubjectGroup,
    );
  }

  Widget buildBody(List<CalendarSubjectGroup> subjectsData) {
    return MobileCalendar(subjectsData: subjectsData);
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
