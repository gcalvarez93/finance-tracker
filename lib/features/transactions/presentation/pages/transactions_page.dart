// Path: lib/features/transactions/presentation/pages/transactions_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/export_format.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_list_tile.dart';
import 'add_transaction_page.dart';

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({super.key});

  @override
  ConsumerState<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends ConsumerState<TransactionsPage> {
  bool _isExporting = false;

  Future<void> _export(ExportFormat format) async {
    setState(() => _isExporting = true);
    final l10n = AppLocalizations.of(context)!;

    final result = await ref.read(exportTransactionsUseCaseProvider)(format);
    final String? path = result.fold((_) => null, (p) => p);

    if (path != null) await OpenFile.open(path);

    if (!mounted) return;
    setState(() => _isExporting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(path != null ? l10n.exportSuccess : l10n.exportError),
        backgroundColor: path != null ? Colors.blueAccent : Colors.red,
      ),
    );
  }

  void _showExportOptions() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.export,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text(l10n.exportPdf),
              onTap: () {
                Navigator.pop(context);
                _export(ExportFormat.pdf);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart, color: Colors.blueAccent),
              title: Text(l10n.exportExcel),
              onTap: () {
                Navigator.pop(context);
                _export(ExportFormat.excel);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final transactionState = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(l10n.navTransactions),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          _isExporting
              ? const Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
              : IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: l10n.export,
            onPressed: _showExportOptions,
          ),
        ],
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
              Text(l10n.noTransactions,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
            ],
          ),
        )
            : RefreshIndicator(
          onRefresh: () =>
              ref.read(transactionProvider.notifier).loadTransactions(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) => TransactionListTile(
              transaction: transactions[index],
              onDismissed: () => ref
                  .read(transactionProvider.notifier)
                  .deleteTransaction(transactions[index].id),
            ),
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