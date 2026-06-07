// Path: lib/features/home/presentation/widgets/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authProvider);
    final transactionState = ref.watch(transactionProvider);

    final userName = authState is AuthAuthenticated
        ? authState.user.name ?? 'Usuario'
        : 'Usuario';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(transactionProvider.notifier).loadTransactions(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hola, $userName 👋',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tu resumen financiero',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: const Icon(Icons.person, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Balance Card
                switch (transactionState) {
                  TransactionLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  TransactionLoaded(:final balance, :final transactions) =>
                      Column(
                        children: [
                          // Balance total
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.green.shade600, Colors.green.shade400],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.balance,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${balance.toStringAsFixed(2)} €',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    _SummaryChip(
                                      label: l10n.income,
                                      amount: transactions
                                          .where((t) => t.type == 'income')
                                          .fold(0.0, (sum, t) => sum + t.amount),
                                      icon: Icons.arrow_upward,
                                      color: Colors.greenAccent,
                                    ),
                                    const SizedBox(width: 16),
                                    _SummaryChip(
                                      label: l10n.expense,
                                      amount: transactions
                                          .where((t) => t.type == 'expense')
                                          .fold(0.0, (sum, t) => sum + t.amount),
                                      icon: Icons.arrow_downward,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Últimas transacciones
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Últimos movimientos',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          if (transactions.isEmpty)
                            Center(
                              child: Column(
                                children: [
                                  const Icon(Icons.receipt_long,
                                      size: 64, color: Colors.grey),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No hay movimientos aún',
                                    style: TextStyle(color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                            )
                          else
                            ...transactions.take(5).map(
                                  (t) => _TransactionTile(transaction: t),
                            ),
                        ],
                      ),
                  TransactionError(:final message) => Center(
                    child: Text(message, style: const TextStyle(color: Colors.red)),
                  ),
                  _ => const SizedBox(),
                },
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          l10n.addTransaction,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  const _SummaryChip({
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
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Text(
              '${amount.toStringAsFixed(2)} €',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final dynamic transaction;

  const _TransactionTile({required this.transaction});

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
                Text(
                  transaction.description,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  transaction.date.toString().substring(0, 10),
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