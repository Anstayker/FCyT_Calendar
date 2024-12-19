import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogInfo extends StatelessWidget {
  const DialogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la fecha y hora actual
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('HH:mm').format(now);

    // Lista de enlaces
    final List<Map<String, String>> links = [
      {'name': 'SCESI', 'url': 'https://www.scesi.org'},
      {
        'name': 'webSIS',
        'url': 'https://websis.umss.edu.bo/serv_estudiantes.asp'
      },
      {'name': 'Discord', 'url': 'https://discord.com/invite/8QRHVRUwFy'},
      {
        'name': 'Cronograma',
        'url':
            'https://capuchino-scesi.web.app/files/Cronograma%20Gestion%202-2021_v5.pdf'
      },
      {
        'name': 'Horarios',
        'url': 'https://capuchino-scesi.web.app/files/regular-2021-02.png'
      },
      {'name': 'Código fuente', 'url': 'https://github.com/scesi/cappuccino'},
    ];

    final List<IconData> icons = [
      Icons.school,
      Icons.web,
      Icons.chat,
      Icons.calendar_today,
      Icons.schedule,
      Icons.code,
    ];

    return AlertDialog(
      title: const Text('Acerca del sistema'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Horarios actualizados el 18 de diciembre a las $formattedTime'),
            const SizedBox(height: 16),
            ...links.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> link = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Icon(icons[index], color: Colors.blue),
                  title: Text(
                    link['name']!,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    // Abrir el enlace en el navegador
                    _launchUrl(link['url']!);
                  },
                ),
              );
            }),
          ],
        ),
      ),
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

  Future<void> _launchUrl(url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
