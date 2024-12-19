import 'package:cappuchino_prototype/core/themes/theme_notifier.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/calendar_career.dart';
import '../../domain/entities/calendar_semester.dart';
import '../../domain/entities/calendar_subject.dart';
import '../../domain/entities/calendar_subject_group.dart';
import '../bloc/calendar_bloc.dart';
import '../widgets/widgets_export_calendar.dart';

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
  Set<CalendarSubjectGroup> selectedGroups = {};
  bool showAdditionalFabs = false;
  bool isHorizontal = false;
  bool isNightModeEnabled = false;

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
              careersInfo.sort((a, b) => a.name.compareTo(b.name));
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
        if (constraints.maxWidth > 950) {
          isHorizontal = true;
          // ! Web Version
          return Scaffold(
            appBar: webCalendarAppBar(),
            body: Row(
              children: [
                SizedBox(
                  width: 250,
                  child: calendarDrawer(careersList, context),
                ),
                Expanded(child: buildBody(subjectsData)),
                const WebSideBar(),
              ],
            ),
          );
        } else {
          isHorizontal = false;
          // ! Mobile Version
          return Scaffold(
            appBar: mobileCalendarAppBar(),
            body: buildBody(subjectsData),
            drawer: calendarDrawer(careersList, context),
            floatingActionButton: MobileFab(
              showAdditionalFabs: showAdditionalFabs,
              onMainFabPressed: () {
                setState(() {
                  showAdditionalFabs = !showAdditionalFabs;
                });
              },
            ),
          );
        }
      },
    );
  }

  GestureDetector semiTransparentContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showAdditionalFabs = false;
        });
      },
      child: AnimatedOpacity(
        opacity: showAdditionalFabs ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
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
          // selectedSemester = semester;
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
          if (selectedGroups.contains(subjectGroup)) {
            selectedGroups.remove(subjectGroup);
          } else {
            selectedGroups.add(subjectGroup);
          }
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
      selectedGroups: selectedGroups,
    );
  }

  Widget buildBody(List<CalendarSubjectGroup> subjectsData) {
    return Stack(
      children: [
        MobileCalendar(subjectsData: subjectsData, isHorizontal: isHorizontal),
        if (showAdditionalFabs) semiTransparentContainer(),
      ],
    );
  }

  AppBar mobileCalendarAppBar() {
    return AppBar(
      title: const Row(
        children: [
          Icon(Icons.coffee),
          SizedBox(width: 8),
          Text('Cappuchino', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        Switch(
          value: Provider.of<ThemeNotifier>(context).isDarkMode,
          onChanged: (value) {
            Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
          },
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const DialogMyCalendars());
            },
            icon: const Icon(Icons.calendar_month)),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => const DialogHelp());
            },
            icon: const Icon(Icons.help_outline)),
      ],
    );
  }

  AppBar webCalendarAppBar() {
    return AppBar(
      title: const Row(
        children: [
          SizedBox(width: 10),
          Icon(Icons.coffee, size: 28),
          SizedBox(width: 20),
          Text('SCESI Cappuchino ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            isNightModeEnabled = !isNightModeEnabled;
            Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
          },
          icon: Provider.of<ThemeNotifier>(context).isDarkMode
              ? const Icon(Icons.nightlight_round)
              : const Icon(Icons.wb_sunny),
          label: Provider.of<ThemeNotifier>(context).isDarkMode
              ? const Text('Modo noche')
              : const Text('Modo día'),
        ),
        const SizedBox(width: 20),
        TextButton.icon(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const DialogMyCalendars());
          },
          icon: const Icon(Icons.calendar_month),
          label: const Text('Mis Horarios'),
        ),
        const SizedBox(width: 20),
        TextButton.icon(
          onPressed: () {
            showDialog(
                context: context, builder: (context) => const DialogHelp());
          },
          icon: const Icon(Icons.help_outline),
          label: const Text('Ayuda'),
        ),
      ],
    );
  }
}
