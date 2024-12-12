import 'package:flutter/material.dart';

import '../widgets/drawer_content.dart';
import '../widgets/mobile_floating_action_button.dart';
import 'calendar_view.dart';

class MobileVersionView extends StatefulWidget {
  const MobileVersionView({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<MobileVersionView> createState() => _MobileVersionViewState();
}

class _MobileVersionViewState extends State<MobileVersionView> {
  bool _showAditionalFabOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cappuchino'),
      ),
      body: buildBody(),
      drawer: const DrawerContent(),
    );
  }

  Stack buildBody() {
    return Stack(
      children: [
        CalendarView(context: context),
        if (_showAditionalFabOptions) ...[
          GestureDetector(
            onTap: () {
              setState(() {
                _showAditionalFabOptions = false;
              });
            },
            child: Container(
              color: Colors.black54,
            ),
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                aditionalFloatingActionButton(
                    Icons.lightbulb_outline, 'Generar horario'),
                const SizedBox(height: 8),
                aditionalFloatingActionButton(
                    Icons.color_lens_outlined, 'Cambiar color'),
                const SizedBox(height: 8),
                aditionalFloatingActionButton(
                    Icons.map_outlined, 'Mapa de la facutad'),
              ],
            ),
          ),
        ],
        Positioned(
          bottom: 16,
          right: 16,
          child: floatingActionButton(),
        ),
      ],
    );
  }

  Widget aditionalFloatingActionButton(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          mini: true,
          onPressed: () {},
          child: Icon(icon),
        ),
      ],
    );
  }

  Widget floatingActionButton() {
    return Row(
      children: [
        if (_showAditionalFabOptions)
          const Text('Opciones adicionales',
              style: TextStyle(color: Colors.white)),
        const SizedBox(width: 8),
        MobileFloatingActionButton(
          onFabPressed: () {
            setState(() {
              _showAditionalFabOptions = !_showAditionalFabOptions;
            });
          },
          icon: _showAditionalFabOptions ? Icons.close : Icons.add,
        ),
      ],
    );
  }
}
