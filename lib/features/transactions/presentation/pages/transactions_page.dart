// Path: lib/features/transactions/presentation/pages/transactions_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/transaction_provider.dart';
import 'add_transaction_page.dart';

class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final transactionState = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(l10n.navTransactions),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: switch (transactionState) {
        TransactionLoading() => const Center(child: CircularProgressIndicator()),
        TransactionLoaded(:final transactions) => transactions.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                l10n.noTransactions,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
            ],
          ),
        )
            : RefreshIndicator(
          onRefresh: () => ref.read(transactionProvider.notifier).loadTransactions(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final t = transactions[index];
              final isIncome = t.type == 'income';

              return Dismissible(
                key: Key(t.id),
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
                onDismissed: (_) =>
                    ref.read(transactionProvider.notifier).deleteTransaction(t.id),
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
                            Text(t.description,
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text(
                              '${t.date.day}/${t.date.month}/${t.date.year}',
                              style:
                              TextStyle(color: Colors.grey.shade500, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${isIncome ? '+' : '-'}${t.amount.toStringAsFixed(2)} €',
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
            },
          ),
        ),
        TransactionError(:final message) =>
            Center(child: Text(message, style: const TextStyle(color: Colors.red))),
        _ => const SizedBox(),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTransactionPage()),
        ),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}