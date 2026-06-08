// Path: lib/features/home/presentation/widgets/summary_chip.dart
import 'package:flutter/material.dart';

class SummaryChip extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  const SummaryChip({
    super.key,
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Text(
              '${amount.toStringAsFixed(2)} €',
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}