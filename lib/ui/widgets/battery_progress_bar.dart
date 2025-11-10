import 'package:flutter/material.dart';

class BatteryProgressBar extends StatelessWidget {
  final int level;

  const BatteryProgressBar({super.key, required this.level});

  Color _getColor() {
    if (level > 60) return Colors.green;
    if (level > 20) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: level / 100,
        minHeight: 15,
        backgroundColor: Colors.white.withOpacity(0.1),
        valueColor: AlwaysStoppedAnimation<Color>(_getColor()),
      ),
    );
  }
}