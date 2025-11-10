import 'package:flutter/material.dart';
import 'package:bateria_application/data/models/battery_info.dart';
import 'package:bateria_application/ui/widgets/stat_card.dart';

class BatteryStatsGrid extends StatelessWidget {
  final BatteryInfo batteryInfo;

  const BatteryStatsGrid({super.key, required this.batteryInfo});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.5,
      children: [
        StatCard(
          icon: Icons.thermostat,
          label: 'Temperatura',
          value: '${batteryInfo.temperature.toStringAsFixed(1)}°C',
          color: Colors.orange,
        ),
        StatCard(
          icon: Icons.bolt,
          label: 'Voltaje',
          value: '${batteryInfo.voltage.toStringAsFixed(2)}V',
          color: Colors.yellow,
        ),
        StatCard(
          icon: Icons.favorite,
          label: 'Salud',
          value: batteryInfo.health,
          color: Colors.green,
        ),
        StatCard(
          icon: Icons.power,
          label: 'Capacidad',
          value: '${batteryInfo.capacity}mAh',
          color: Colors.blue,
        ),
      ],
    );
  }
}