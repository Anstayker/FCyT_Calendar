import 'package:flutter/material.dart';

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
          additionalFab(Icons.print_outlined, 80, 'Imprimir', onMainFabPressed),
          additionalFab(Icons.save_outlined, 150, 'Guardar', onMainFabPressed),
          additionalFab(Icons.map_outlined, 220, 'Mapa', onMainFabPressed),
          additionalFab(Icons.lightbulb_outline, 290, 'Sugerir horario',
              onMainFabPressed),
          additionalFab(Icons.color_lens_outlined, 360, 'Cambiar colores',
              onMainFabPressed),
          additionalFab(
              Icons.info_outline, 430, 'Información', onMainFabPressed),
        ],
        mainFab(),
      ],
    );
  }

  Widget additionalFab(IconData icon, double bottomPadding, String text,
      VoidCallback onPressed) {
    return Padding(
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
            },
            child: Icon(icon),
          ),
        ],
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
