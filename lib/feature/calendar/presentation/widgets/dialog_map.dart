import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DialogMap extends StatefulWidget {
  const DialogMap({
    super.key,
    required this.isWeb,
  });

  final bool isWeb;

  @override
  State<DialogMap> createState() => _DialogMapState();
}

class _DialogMapState extends State<DialogMap> {
  late PhotoViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PhotoViewController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      title: const Text('Mapa de la facultad'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isWeb
                  ? 'Doble clic para hacer zoom en la imagen.'
                  : 'Haz zoom en la imagen con dos dedos.',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Container(
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.6,
              color: Colors.grey,
              child: Stack(
                children: [
                  PhotoView(
                    controller: _controller,
                    imageProvider: const AssetImage('assets/mapa.png'),
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.white),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            _controller.scale = _controller.scale! * 1.2;
                          },
                          child: const Icon(Icons.zoom_in),
                        ),
                        const SizedBox(height: 10),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            _controller.scale = _controller.scale! / 1.2;
                          },
                          child: const Icon(Icons.zoom_out),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
