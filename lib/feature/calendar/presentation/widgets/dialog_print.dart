import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DialogPrint extends StatelessWidget {
  const DialogPrint({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Imprimir horario'),
      content: const Text('¿Desea imprimir el horario actual?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            await _printSchedule();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          child: const Text('Imprimir'),
        ),
      ],
    );
  }

  Future<void> _printSchedule() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          // una tabla con datos de prueba para impirimir
          // ignore: deprecated_member_use
          return pw.Table.fromTextArray(
            context: context,
            data: <List<String>>[
              <String>['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'],
              <String>['Clase 1', '', 'Clase 3', 'Clase 4', ''],
              <String>['Clase 6', 'Clase 7', '', 'Clase 9', 'Clase 10'],
              <String>['', '', 'Clase 13', 'Clase 14', ''],
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
