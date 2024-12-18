import 'package:flutter/material.dart';

class DialogSave extends StatelessWidget {
  const DialogSave({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Guardar horario'),
      content: const Text('¿Desea guardar el horario actual?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Horario guardado correctamente'),
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
