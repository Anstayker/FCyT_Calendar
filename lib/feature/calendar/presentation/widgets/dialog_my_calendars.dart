import 'package:flutter/material.dart';

class DialogMyCalendars extends StatelessWidget {
  const DialogMyCalendars({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Función no disponible'),
      content: const Text(
          'Disculpe las molestias, esta función aún no está disponible'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
