// Path: lib/features/home/presentation/widgets/dashboard_transaction_tile.dart
import 'package:flutter/material.dart';
import '../../../transactions/domain/entities/transaction_entity.dart';

class DashboardTransactionTile extends StatelessWidget {
  final TransactionEntity transaction;

  const DashboardTransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isIncome ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isIncome ? Icons.arrow_upward : Icons.arrow_downward,
              color: isIncome ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.description,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}${transaction.amount.toStringAsFixed(2)} €',
            style: TextStyle(
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}