import 'package:flutter/material.dart';

class TechnicalInfoCard extends StatelessWidget {
  const TechnicalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        children: [
          _InfoRow(label: '📦 Paquete', value: 'battery_plus ^5.0.0'),
          SizedBox(height: 8),
          _InfoRow(label: '🔐 Permisos', value: 'BATTERY_STATS'),
          SizedBox(height: 8),
          _InfoRow(label: '📱 Plataforma', value: 'Android/iOS/Web'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}