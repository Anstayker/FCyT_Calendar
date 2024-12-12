import 'package:flutter/material.dart';

import '../widgets/mobile_calendar_widgets.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // TODO: Revisar el maxWidth
        if (constraints.maxWidth > 800) {
          // ! Web Version
          return Scaffold(
            appBar: calendarAppBar(),
            body: Row(
              children: [
                SizedBox(width: 250, child: calendarDrawer()),
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
            drawer: calendarDrawer(),
            floatingActionButton: mobileMainFab(),
          );
        }
      },
    );
  }

  Widget buildBody() {
    return const MobileCalendar();
  }

  FloatingActionButton mobileMainFab() =>
      FloatingActionButton(onPressed: () {});

  Drawer calendarDrawer() {
    return Drawer(
      child: ListView(
        children: [
          drawerCareerTitle(),
          careerListTile('Ingeniería en Sistemas'),
          careerListTile('Ingeniería en Electrónica'),
          careerListTile('Ingeniería en Mecatrónica'),
          careerListTile('Ingeniería en Industrial'),
        ],
      ),
    );
  }

  Padding drawerCareerTitle() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Carreras disponibles', style: TextStyle(fontSize: 20)),
    );
  }

  ListTile careerListTile(String careerName) {
    return ListTile(
      title: Text(careerName),
      onTap: () {},
    );
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
    );
  }
}
