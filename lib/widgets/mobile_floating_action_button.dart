import 'package:flutter/material.dart';

class MobileFloatingActionButton extends StatelessWidget {
  final VoidCallback onFabPressed;
  final IconData icon;

  const MobileFloatingActionButton({
    super.key,
    required this.onFabPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onFabPressed,
      child: Icon(icon),
    );
  }
}
