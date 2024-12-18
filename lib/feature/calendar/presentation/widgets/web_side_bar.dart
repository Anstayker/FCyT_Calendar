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
            showDialogHelper(context, const DialogPrint());
          }),
          sideBarButton('Guardar', Icons.save_outlined, () {
            showDialogHelper(context, const DialogSave());
          }),
          sideBarButton('Mapa', Icons.map_outlined, () {}),
          sideBarButton('Sugerir Horario', Icons.lightbulb_outline, () {
            showDialogHelper(context, const DialogInProgress());
          }),
          sideBarButton('Cambiar Colores', Icons.color_lens_outlined, () {
            showDialogHelper(context, const DialogInProgress());
          }),
          sideBarButton('Información', Icons.info_outline, () {
            showDialogHelper(context, const DialogInProgress());
          }),
        ],
      ),
    );
  }

  Future<dynamic> showDialogHelper(BuildContext context, Widget dialog) {
    return showDialog(context: context, builder: (context) => dialog);
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
