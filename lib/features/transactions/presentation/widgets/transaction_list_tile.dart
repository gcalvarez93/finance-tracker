// Path: lib/features/transactions/presentation/widgets/transaction_list_tile.dart
import 'package:flutter/material.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionListTile extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback onDismissed;

  const TransactionListTile({
    super.key,
    required this.transaction,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDismissed(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
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
      ),
    );
  }
}