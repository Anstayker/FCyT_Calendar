import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import 'widgets_export_calendar.dart';

class DialogCalendarGenerator extends StatefulWidget {
  const DialogCalendarGenerator({super.key});

  @override
  State<DialogCalendarGenerator> createState() =>
      _DialogCalendarGeneratorState();
}

class _DialogCalendarGeneratorState extends State<DialogCalendarGenerator> {
  final List<String> subjects = [
    'Inglés I',
    'Física General',
    'Álgebra I',
    'Cálculo I',
    'Introducción a la Programación',
  ];

  List<String> selectedSubjects = [];
  bool morningPreferred = false;
  bool afternoonPreferred = false;
  bool eveningPreferred = false;
  int maxConflicts = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sugerencias de Horarios'),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Elige tus preferencias recibir recomendaciones de horarios',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text('Selecciona tus materias',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              subjectsDropdown(),
              const SizedBox(height: 20),
              const Text('Horarios preferidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              buildCheckbox('Mañana', morningPreferred, (bool? value) {
                setState(() {
                  morningPreferred = value ?? false;
                });
              }),
              buildCheckbox('Tarde', afternoonPreferred, (bool? value) {
                setState(() {
                  afternoonPreferred = value ?? false;
                });
              }),
              buildCheckbox('Noche', eveningPreferred, (bool? value) {
                setState(() {
                  eveningPreferred = value ?? false;
                });
              }),
              const SizedBox(height: 20),
              const Text('Choques de materias máximos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              conflictsCounter(),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Chip(
                    label: Text('BETA'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CalendarSelectionDialog();
                        },
                      );
                    },
                    child: const Text('Generar Calendario'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row conflictsCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (maxConflicts > 0) {
                maxConflicts--;
              }
            });
          },
        ),
        Text(
          '$maxConflicts',
          style: const TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              if (maxConflicts < 9) {
                maxConflicts++;
              }
            });
          },
        ),
      ],
    );
  }

  MultiDropdown<String> subjectsDropdown() {
    return MultiDropdown(
      searchEnabled: true,
      items: subjects
          .map(
              (subject) => DropdownItem<String>(value: subject, label: subject))
          .toList(),
      onSelectionChange: (List<String> values) {
        setState(() {
          selectedSubjects = values;
        });
      },
    );
  }

  Widget buildCheckbox(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
