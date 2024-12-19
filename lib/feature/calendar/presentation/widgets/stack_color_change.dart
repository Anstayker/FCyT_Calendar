import 'package:flutter/material.dart';

class StackColorChange extends StatefulWidget {
  const StackColorChange({super.key});

  @override
  State<StackColorChange> createState() => _StackColorChangeState();
}

class _StackColorChangeState extends State<StackColorChange> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.blue,
  ];

  Color selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cambiar de colores'),
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: selectedColor,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: colors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  color: color,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Seleccione un color',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text('Esta funcionalidad sigue en progreso'),
          const Text('y aún no está disponible'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
