import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bateria_application/data/models/battery_info.dart';
import 'package:bateria_application/data/services/battery_service.dart';
import 'package:bateria_application/ui/widgets/battery_header.dart';
import 'package:bateria_application/ui/widgets/battery_main_card.dart';
import 'package:bateria_application/ui/widgets/battery_stats_grid.dart';
import 'package:bateria_application/ui/widgets/low_battery_alert.dart';
//import 'package:bateria_application/ui/widgets/technical_info_card.dart';

class BatteryMonitorScreen extends StatefulWidget {
  const BatteryMonitorScreen({super.key});

  @override
  State<BatteryMonitorScreen> createState() => _BatteryMonitorScreenState();
}

class _BatteryMonitorScreenState extends State<BatteryMonitorScreen> {
  final BatteryService _batteryService = BatteryService();
  BatteryInfo? _batteryInfo;
  Timer? _updateTimer;
  StreamSubscription? _stateSubscription;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBatteryInfo();
    _subscribeToStateChanges();
    _startPeriodicUpdate();
  }

  Future<void> _loadBatteryInfo() async {
    try {
      final info = await _batteryService.getBatteryInfo();
      setState(() {
        _batteryInfo = info;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _subscribeToStateChanges() {
    _stateSubscription = _batteryService.onBatteryStateChanged.listen((_) {
      _loadBatteryInfo();
    });
  }

  void _startPeriodicUpdate() {
    _updateTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) _loadBatteryInfo();
    });
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0f172a),
              Color(0xFF1e3a8a),
              Color(0xFF0f172a),
            ],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const BatteryHeader(),
                      const SizedBox(height: 30),
                      BatteryMainCard(batteryInfo: _batteryInfo!),
                      const SizedBox(height: 20),
                      BatteryStatsGrid(batteryInfo: _batteryInfo!),
                      const SizedBox(height: 20),
                      if (_batteryInfo!.isLowBattery)
                        const LowBatteryAlert(),
                      const SizedBox(height: 20),
                      // const TechnicalInfoCard(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}