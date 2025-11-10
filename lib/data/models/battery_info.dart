import 'package:battery_plus/battery_plus.dart';

class BatteryInfo {
  final int level;
  final BatteryState state;
  final double temperature;
  final double voltage;
  final String health;
  final int capacity;

  BatteryInfo({
    required this.level,
    required this.state,
    required this.temperature,
    required this.voltage,
    required this.health,
    required this.capacity,
  });

  bool get isCharging => state == BatteryState.charging;
  bool get isLowBattery => level < 20 && !isCharging;
  
  String get stateText {
    switch (state) {
      case BatteryState.charging:
        return 'Cargando';
      case BatteryState.full:
        return 'Completa';
      case BatteryState.discharging:
        return 'En uso';
      default:
        return 'Desconocido';
    }
  }
}