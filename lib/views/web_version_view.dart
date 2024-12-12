import 'package:flutter/material.dart';
import 'calendar_view.dart';

class WebVersionView extends StatefulWidget {
  const WebVersionView({super.key});

  @override
  State<WebVersionView> createState() => _WebVersionViewState();
}

class _WebVersionViewState extends State<WebVersionView> {
  bool showingCareers = true;
  String? selectedSemester;
  List<String> careers = [
    'Ingeniería en Sistemas',
    'Ingeniería en Electrónica',
    'Ingeniería en Mecatrónica',
    'Ingeniería en Industrial',
    'Ingeniería en Mecánica',
    'Ingeniería en Eléctrica',
  ];

  List<String> semesters = [
    '1er Semestre',
    '2do Semestre',
    '3er Semestre',
    '4to Semestre',
    '5to Semestre',
    '6to Semestre',
    '7mo Semestre',
    '8vo Semestre',
    '9no Semestre',
    '10mo Semestre',
  ];

  Map<String, List<String>> subjects = {
    '1er Semestre': ['Matemáticas', 'Física', 'Química'],
    '2do Semestre': ['Programación', 'Electrónica', 'Mecánica'],
    '3er Semestre': ['Álgebra', 'Cálculo', 'Estadística'],
    // Agrega más materias para otros semestres según sea necesario
  };

  Map<String, bool> selectedSubjects = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cappuchino'),
      ),
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 250.0,
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!showingCareers)
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              showingCareers = true;
                              selectedSemester = null;
                            });
                          },
                        ),
                      const Spacer(),
                      Text(
                        showingCareers
                            ? 'Selecciona una carrera'
                            : 'Selecciona un semestre',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const Spacer(),
                      if (showingCareers)
                        const SizedBox(
                            width: 48), // Espacio reservado para el icono
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: _buildList(),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Center(child: CalendarView(context: context)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> list = [];
    if (showingCareers) {
      list.addAll(careers.map((item) => ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                showingCareers = false;
              });
            },
          )));
    } else {
      for (var semester in semesters) {
        list.add(ListTile(
          title: Text(semester),
          onTap: () {
            setState(() {
              selectedSemester = selectedSemester == semester ? null : semester;
            });
          },
        ));
        if (selectedSemester == semester && subjects[semester] != null) {
          list.addAll(subjects[semester]!.map((subject) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  leading: Checkbox(
                    value: selectedSubjects[subject] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedSubjects[subject] = value ?? false;
                      });
                    },
                  ),
                  title: Text(subject),
                  onTap: () {
                    setState(() {
                      selectedSubjects[subject] =
                          !(selectedSubjects[subject] ?? false);
                    });
                  },
                ),
              )));
        }
      }
    }
    return list;
  }
}
