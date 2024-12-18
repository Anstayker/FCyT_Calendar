import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DialogMap extends StatelessWidget {
  const DialogMap({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      title: const Text('Mapa de la facultad'),
      content: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.8,
        color: Colors.grey,
        child: PhotoView(
          imageProvider: const AssetImage('assets/mapa.png'),
          backgroundDecoration: const BoxDecoration(color: Colors.white),
        ),
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
