import 'package:flutter/material.dart';
import 'package:bateria_application/data/models/battery_info.dart';
import 'package:bateria_application/ui/theme/app_theme.dart';
import 'package:bateria_application/ui/widgets/battery_icon_widget.dart';
import 'package:bateria_application/ui/widgets/battery_progress_bar.dart';

class BatteryMainCard extends StatelessWidget {
  final BatteryInfo batteryInfo;

  const BatteryMainCard({super.key, required this.batteryInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          BatteryIconWidget(batteryInfo: batteryInfo),
          const SizedBox(height: 20),
          Text(
            '${batteryInfo.level}%',
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _buildStateChip(),
          const SizedBox(height: 25),
          BatteryProgressBar(level: batteryInfo.level),
        ],
      ),
    );
  }

  Widget _buildStateChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: batteryInfo.isCharging
            ? Colors.green.withOpacity(0.2)
            : Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            batteryInfo.isCharging ? Icons.bolt : Icons.battery_std,
            size: 20,
            color: batteryInfo.isCharging
                ? Colors.green.shade300
                : Colors.blue.shade300,
          ),
          const SizedBox(width: 8),
          Text(
            batteryInfo.stateText,
            style: TextStyle(
              color: batteryInfo.isCharging
                  ? Colors.green.shade300
                  : Colors.blue.shade300,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}