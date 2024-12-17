import 'package:flutter/material.dart';

import 'widgets_export_calendar.dart';

class WebSideBar extends StatelessWidget {
  const WebSideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          sideBarButton('Imprimir', Icons.print_outlined, () {
            showDialogHelper(context);
          }),
          sideBarButton('Guardar', Icons.save_outlined, () {
            showDialogHelper(context);
          }),
          sideBarButton('Mapa', Icons.map_outlined, () {}),
          sideBarButton('Sugerir Horario', Icons.lightbulb_outline, () {
            showDialogHelper(context);
          }),
          sideBarButton('Cambiar Colores', Icons.color_lens_outlined, () {
            showDialogHelper(context);
          }),
          sideBarButton('Información', Icons.info_outline, () {
            showDialogHelper(context);
          }),
        ],
      ),
    );
  }

  Future<dynamic> showDialogHelper(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => const DialogSave());
  }

  IconButton sideBarButton(
      String tooltip, IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 30,
      tooltip: tooltip,
    );
  }
}
