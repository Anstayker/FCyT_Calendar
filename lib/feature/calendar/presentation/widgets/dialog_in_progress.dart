import 'package:flutter/material.dart';

class DialogInProgress extends StatelessWidget {
  const DialogInProgress({super.key});

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
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
