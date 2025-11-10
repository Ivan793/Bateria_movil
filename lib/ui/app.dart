import 'package:flutter/material.dart';
import 'package:bateria_application/ui/screens/battery_monitor_screen.dart';
import 'package:bateria_application/ui/theme/app_theme.dart';

class BateriaApp extends StatelessWidget {
  const BateriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitor de Batería',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const BatteryMonitorScreen(),
    );
  }
}