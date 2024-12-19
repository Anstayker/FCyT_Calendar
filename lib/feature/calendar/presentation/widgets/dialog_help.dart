import 'package:flutter/material.dart';

class DialogHelp extends StatelessWidget {
  const DialogHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ayuda'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Instrucciones de uso:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildSection(
              icon: Icons.calendar_today,
              title: 'Armar tu horario',
              instructions: [
                'Selecciona los horarios disponibles en la sección de la izquierda.',
                'Busca la materia y docente que deseas seleccionar para tu horario.',
                'Haz clic en los grupos que deseas agregar/quitar a tu horario.',
                'Revisa tu horario para asegurarte de que los horarios están correctos.',
              ],
            ),
            _buildSection(
              icon: Icons.build,
              title: 'Herramientas adicionales',
              instructions: [
                'Utiliza las herramientas de la derecha para acciones adicionales.',
                'Puedes guardar tu horario, ver el mapa de la facultado entre otras opciones.',
              ],
            ),
            _buildSection(
              icon: Icons.help_outline,
              title: 'Soporte',
              instructions: [
                'Si tienes dudas adicionales, ponte en contacto con el soporte.',
                'Envía un correo a soporte@scesi.com para asistencia personalizada.',
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<String> instructions,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.blue),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ...instructions.map((instruction) => Padding(
                padding: const EdgeInsets.only(left: 72.0, bottom: 4.0),
                child: SelectableText('• $instruction'),
              )),
        ],
      ),
    );
  }
}
