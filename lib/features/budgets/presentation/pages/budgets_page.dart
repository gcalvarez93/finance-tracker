// Path: lib/features/budgets/presentation/pages/budgets_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/presentation/providers/category_provider.dart';
import '../providers/budget_provider.dart';

class BudgetsPage extends ConsumerWidget {
  const BudgetsPage({super.key});

  String _monthKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedMonth = ref.watch(selectedMonthProvider);
    final budgetState = ref.watch(budgetProvider);
    final monthKey = _monthKey(selectedMonth);

    ref.listen(selectedMonthProvider, (_, next) {
      ref.read(budgetProvider.notifier).loadBudgets(_monthKey(next));
    });

    if (budgetState is BudgetInitial) {
      Future.microtask(() =>
          ref.read(budgetProvider.notifier).loadBudgets(monthKey));
    }

    final monthNames = [
      '', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(l10n.navBudgets),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    final prev = DateTime(selectedMonth.year, selectedMonth.month - 1);
                    ref.read(selectedMonthProvider.notifier).state = prev;
                  },
                ),
                Text(
                  '${monthNames[selectedMonth.month]} ${selectedMonth.year}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    final next = DateTime(selectedMonth.year, selectedMonth.month + 1);
                    ref.read(selectedMonthProvider.notifier).state = next;
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: switch (budgetState) {
              BudgetLoading() => const Center(child: CircularProgressIndicator()),
              BudgetLoaded(:final budgets) => budgets.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.savings_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(l10n.noBudgets,
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                  ],
                ),
              )
                  : RefreshIndicator(
                onRefresh: () =>
                    ref.read(budgetProvider.notifier).loadBudgets(monthKey),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: budgets.length,
                  itemBuilder: (context, index) {
                    final budget = budgets[index];
                    final percentage = budget.percentage.clamp(0.0, 1.0);
                    final isOver = budget.isOverBudget;
                    final progressColor = isOver
                        ? Colors.red
                        : percentage > 0.8
                        ? Colors.orange
                        : Colors.green;

                    return Dismissible(
                      key: Key(budget.id),
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
                      onDismissed: (_) {
                        ref.read(budgetProvider.notifier).deleteBudget(budget.id, monthKey);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.budgetDeleted)),
                        );
                      },
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(budget.categoryIcon,
                                    style: const TextStyle(fontSize: 24)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(budget.categoryName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 16)),
                                ),
                                if (isOver)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(l10n.budgetOverLimit,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: percentage,
                                backgroundColor: Colors.grey.shade100,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(progressColor),
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _BudgetStat(
                                    label: l10n.budgetSpent,
                                    amount: budget.spent,
                                    color: progressColor),
                                _BudgetStat(
                                    label: l10n.budgetRemaining,
                                    amount: budget.remaining.abs(),
                                    color: isOver ? Colors.red : Colors.green),
                                _BudgetStat(
                                    label: l10n.budgetLimit,
                                    amount: budget.amount,
                                    color: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              BudgetError(:final message) =>
                  Center(child: Text(message, style: const TextStyle(color: Colors.red))),
              _ => const SizedBox(),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _AddBudgetSheet(selectedMonth: selectedMonth),
        ),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _AddBudgetSheet extends ConsumerStatefulWidget {
  final DateTime selectedMonth;

  const _AddBudgetSheet({required this.selectedMonth});

  @override
  ConsumerState<_AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends ConsumerState<_AddBudgetSheet> {
  final _limitController = TextEditingController();
  CategoryEntity? _selectedCategory;
  late int _month;
  late int _year;

  @override
  void initState() {
    super.initState();
    _month = widget.selectedMonth.month;
    _year = widget.selectedMonth.year;
    Future.microtask(() =>
        ref.read(categoryProvider.notifier).loadCategories());
  }

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryState = ref.watch(categoryProvider);
    final categories = categoryState is CategoryLoaded
        ? categoryState.categories
        : <CategoryEntity>[];

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.addBudget,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          categoryState is CategoryLoading
              ? const Center(child: CircularProgressIndicator())
              : DropdownButtonFormField<CategoryEntity>(
            value: _selectedCategory,
            hint: Text(l10n.selectCategory),
            decoration: InputDecoration(
              labelText: l10n.category,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
            items: categories.map((cat) => DropdownMenuItem(
              value: cat,
              child: Row(
                children: [
                  Text(cat.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(cat.name),
                ],
              ),
            )).toList(),
            onChanged: (value) => setState(() => _selectedCategory = value),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _limitController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '${l10n.budgetLimit} (€)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _month,
                  decoration: InputDecoration(
                    labelText: l10n.selectMonth,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: List.generate(12, (i) => i + 1)
                      .map((m) => DropdownMenuItem(value: m, child: Text('$m')))
                      .toList(),
                  onChanged: (value) => setState(() => _month = value!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _year,
                  decoration: InputDecoration(
                    labelText: l10n.selectYear,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [2024, 2025, 2026, 2027]
                      .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                      .toList(),
                  onChanged: (value) => setState(() => _year = value!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (_selectedCategory == null) return;
              final limit = double.tryParse(
                  _limitController.text.replaceAll(',', '.'));
              if (limit == null || limit <= 0) return;

              await ref.read(budgetProvider.notifier).createBudget(
                categoryId: _selectedCategory!.id,
                limit: limit,
                month: _month,
                year: _year,
              );

              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.budgetCreated),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(l10n.save, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class _BudgetStat extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _BudgetStat({required this.label, required this.amount, required this.color});

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