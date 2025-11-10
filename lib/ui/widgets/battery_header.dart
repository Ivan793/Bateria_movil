import 'package:flutter/material.dart';

class BatteryHeader extends StatelessWidget {
  const BatteryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Monitor de Batería',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Programación Móvil - Flutter',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xB3FFFFFF),
          ),
        ),
      ],
    );
  }
}