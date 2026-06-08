// Path: lib/features/budgets/presentation/widgets/budget_stat.dart
import 'package:flutter/material.dart';

class BudgetStat extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const BudgetStat({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        Text(
          '${amount.toStringAsFixed(2)} €',
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}