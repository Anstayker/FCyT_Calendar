import 'package:flutter/material.dart';
import '../../domain/entities/calendar_career.dart';

class CareerListTile extends StatelessWidget {
  const CareerListTile({
    super.key,
    required this.career,
    required this.onTap,
  });

  final CalendarCareer career;
  final VoidCallback onTap;

  static const Map<String, IconData> careerIcons = {
    'Licenciatura en Ingeniería Informática': Icons.computer,
    'Licenciatura en Alimentos': Icons.fastfood,
    'Licenciatura en Biología': Icons.biotech,
    'Licenciatura en Biotecnología': Icons.science,
    'Licenciatura en Civil': Icons.engineering,
    'Licenciatura en Eléctrica': Icons.electrical_services,
    'Licenciatura en Electromecánica': Icons.build,
    'Licenciatura en Electrónica': Icons.memory,
    'Licenciatura en Energía': Icons.bolt,
    'Licenciatura en Física': Icons.functions,
    'Licenciatura en Industrial': Icons.factory,
    'Licenciatura en Matemática': Icons.calculate,
    'Licenciatura en Mecánica': Icons.build_circle,
    'Licenciatura en Química': Icons.science,
    'Licenciatura en Sistemas': Icons.settings,
    'Licenciatura en Informática': Icons.code,
  };

  static const Map<String, Color> careerColors = {
    'Licenciatura en Ingeniería Informática': Colors.blue,
    'Licenciatura en Alimentos': Colors.green,
    'Licenciatura en Biología': Colors.teal,
    'Licenciatura en Biotecnología': Colors.purple,
    'Licenciatura en Civil': Colors.orange,
    'Licenciatura en Eléctrica': Colors.deepOrange,
    'Licenciatura en Electromecánica': Colors.red,
    'Licenciatura en Electrónica': Colors.cyan,
    'Licenciatura en Energía': Colors.amber,
    'Licenciatura en Física': Colors.indigo,
    'Licenciatura en Industrial': Colors.brown,
    'Licenciatura en Matemática': Colors.pink,
    'Licenciatura en Mecánica': Colors.blueGrey,
    'Licenciatura en Química': Colors.deepPurple,
    'Licenciatura en Sistemas': Colors.blueGrey,
    'Licenciatura en Informática': Colors.lightBlue,
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        careerIcons[career.name] ?? Icons.school,
        color: careerColors[career.name] ?? Colors.grey,
      ),
      title: Text(career.name),
      onTap: onTap,
    );
  }
}
