import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:bateria_application/data/models/battery_info.dart';

class BatteryIconWidget extends StatefulWidget {
  final BatteryInfo batteryInfo;

  const BatteryIconWidget({super.key, required this.batteryInfo});

  @override
  State<BatteryIconWidget> createState() => _BatteryIconWidgetState();
}

class _BatteryIconWidgetState extends State<BatteryIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getBatteryIcon() {
    if (widget.batteryInfo.state == BatteryState.charging) {
      return Icons.battery_charging_full;
    }
    if (widget.batteryInfo.level > 90) return Icons.battery_full;
    if (widget.batteryInfo.level > 60) return Icons.battery_6_bar;
    if (widget.batteryInfo.level > 30) return Icons.battery_3_bar;
    if (widget.batteryInfo.level > 10) return Icons.battery_2_bar;
    return Icons.battery_1_bar;
  }

  Color _getBatteryColor() {
    if (widget.batteryInfo.level > 60) return Colors.green;
    if (widget.batteryInfo.level > 20) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Icon(
            _getBatteryIcon(),
            size: 80,
            color: widget.batteryInfo.isCharging
                ? Colors.yellow
                : _getBatteryColor(),
          ),
        );
      },
    );
  }
}