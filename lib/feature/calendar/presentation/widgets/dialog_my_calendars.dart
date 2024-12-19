import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DialogMyCalendars extends StatefulWidget {
  const DialogMyCalendars({super.key});

  @override
  State<DialogMyCalendars> createState() => _DialogMyCalendarsState();
}

class _DialogMyCalendarsState extends State<DialogMyCalendars> {
  final List<String> savedCalendars = [
    'Mi Horario',
    'Mi Horario',
    'Mi Horario',
    // Agrega más horarios guardados según sea necesario
  ];

  int selectedIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Mis horarios'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
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
                    itemCount: savedCalendars.length,
                    itemBuilder: (context, index, realIndex) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Imagen de:',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                savedCalendars[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
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
                    children: savedCalendars.asMap().entries.map((entry) {
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
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar el horario
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    // Lógica para visualizar el horario
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar el horario
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
