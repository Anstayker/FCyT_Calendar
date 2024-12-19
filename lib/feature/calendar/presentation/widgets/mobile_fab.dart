import 'package:flutter/material.dart';

import 'dialog_calendar_generator.dart';
import 'widgets_export_calendar.dart';

class MobileFab extends StatelessWidget {
  final bool showAdditionalFabs;
  final VoidCallback onMainFabPressed;

  const MobileFab({
    super.key,
    required this.showAdditionalFabs,
    required this.onMainFabPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (showAdditionalFabs) ...[
          additionalFab(Icons.print_outlined, 80, 'Imprimir', context,
              onMainFabPressed, const DialogPrint()),
          additionalFab(Icons.save_outlined, 150, 'Guardar', context,
              onMainFabPressed, const DialogSave()),
          additionalFab(Icons.map_outlined, 220, 'Mapa', context,
              onMainFabPressed, const DialogMap(isWeb: false)),
          additionalFab(Icons.lightbulb_outline, 290, 'Sugerir horario',
              context, onMainFabPressed, const DialogCalendarGenerator()),
          additionalFab(Icons.color_lens_outlined, 360, 'Cambiar colores',
              context, onMainFabPressed, const StackColorChange()),
          additionalFab(Icons.info_outline, 430, 'Información', context,
              onMainFabPressed, const DialogInfo()),
        ],
        mainFab(),
      ],
    );
  }

  Widget additionalFab(IconData icon, double bottomPadding, String text,
      BuildContext context, VoidCallback onPressed, Widget dialog) {
    return AnimatedOpacity(
      opacity: showAdditionalFabs ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding, right: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            FloatingActionButton(
              mini: true,
              onPressed: () {
                onPressed();
                showDialog(context: context, builder: (context) => dialog);
              },
              child: Icon(icon),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton mainFab() {
    return FloatingActionButton(
      onPressed: onMainFabPressed,
      child:
          showAdditionalFabs ? const Icon(Icons.close) : const Icon(Icons.add),
    );
  }
}
