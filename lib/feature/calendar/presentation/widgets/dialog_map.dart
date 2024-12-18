import 'package:flutter/material.dart';

class DialogMap extends StatelessWidget {
  const DialogMap({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Mapa de la facultad'),
      content: const Text('Imaginemos que aquí hay un mapa de la facultad'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
