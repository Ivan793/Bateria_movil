import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:bateria_application/data/models/battery_info.dart';

class BatteryService {
  final Battery _battery = Battery();
  
  Future<BatteryInfo> getBatteryInfo() async {
    try {
      final level = await _battery.batteryLevel;
      final state = await _battery.batteryState;
      
      return BatteryInfo(
        level: level,
        state: state,
        temperature: _simulateTemperature(level),
        voltage: _simulateVoltage(level),
        health: _calculateHealth(level),
        capacity: 3000,
      );
    } catch (e) {
      throw Exception('Error al obtener información de batería: $e');
    }
  }
  
  Stream<BatteryState> get onBatteryStateChanged {
    return _battery.onBatteryStateChanged;
  }
  
  double _simulateTemperature(int level) {
    return 25 + (DateTime.now().millisecond % 20);
  }
  
  double _simulateVoltage(int level) {
    return 3.5 + (level / 100) * 0.7;
  }
  
  String _calculateHealth(int level) {
    final temp = _simulateTemperature(level);
    if (temp > 40) return 'Caliente';
    if (temp < 30) return 'Buena';
    return 'Normal';
  }
}