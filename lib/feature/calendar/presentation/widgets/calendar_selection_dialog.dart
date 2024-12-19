import 'package:cappuchino_prototype/feature/calendar/presentation/widgets/dialog_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CalendarSelectionDialog extends StatefulWidget {
  const CalendarSelectionDialog({super.key});

  @override
  State<CalendarSelectionDialog> createState() =>
      _CalendarSelectionDialogState();
}

class _CalendarSelectionDialogState extends State<CalendarSelectionDialog> {
  final List<String> calendars = [
    'Calendario 1',
    'Calendario 2',
    'Calendario 3',
    // Agrega más calendarios según sea necesario
  ];

  int selectedIndex = 0;
  CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Escoge tu Horario'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200, // Altura del carrusel
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: calendars.length,
                    itemBuilder: (context, index, realIndex) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'Imagen de: ${calendars[index]}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      _carouselController.previousPage();
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      _carouselController.nextPage();
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: calendars.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        selectedIndex == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  tooltip: 'Regresar',
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  tooltip: 'Previsualizar Calendario',
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const DialogInProgress());
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para aplicar el calendario
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aplicar Calendario'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
