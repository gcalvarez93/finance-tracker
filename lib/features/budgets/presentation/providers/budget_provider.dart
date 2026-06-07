// Path: lib/features/budgets/presentation/providers/budget_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/budget_remote_datasource.dart';
import '../../data/repositories/budget_repository_impl.dart';
import '../../domain/entities/budget_entity.dart';
import '../../domain/repositories/i_budget_repository.dart';

// Datasource
final budgetDatasourceProvider = Provider<IBudgetRemoteDatasource>(
      (ref) => BudgetRemoteDatasource(ref.watch(dioClientProvider)),
);

// Repository
final budgetRepositoryProvider = Provider<IBudgetRepository>(
      (ref) => BudgetRepositoryImpl(ref.watch(budgetDatasourceProvider)),
);

// Selected month provider
final selectedMonthProvider = StateProvider<DateTime>(
      (ref) => DateTime(DateTime.now().year, DateTime.now().month),
);

// State
sealed class BudgetState {}
class BudgetInitial extends BudgetState {}
class BudgetLoading extends BudgetState {}
class BudgetLoaded extends BudgetState {
  final List<BudgetEntity> budgets;
  BudgetLoaded(this.budgets);
}
class BudgetError extends BudgetState {
  final String message;
  BudgetError(this.message);
}

// Notifier
class BudgetNotifier extends StateNotifier<BudgetState> {
  final IBudgetRepository _repository;

  BudgetNotifier(this._repository) : super(BudgetInitial());

  Future<void> loadBudgets(String month) async {
    state = BudgetLoading();
    final result = await _repository.getBudgets(month);
    result.fold(
          (failure) => state = BudgetError(failure.toString()),
          (budgets) => state = BudgetLoaded(budgets),
    );
  }

  Future<void> createBudget({
    required String categoryId,
    required double limit,
    required int month,
    required int year,
  }) async {
    final result = await _repository.createBudget(
      categoryId: categoryId,
      limit: limit,
      month: month,
      year: year,
    );
    result.fold(
          (failure) => state = BudgetError(failure.toString()),
          (_) => loadBudgets('$year-${month.toString().padLeft(2, '0')}'),
    );
  }

  Future<void> deleteBudget(String id, String month) async {
    final result = await _repository.deleteBudget(id);
    result.fold(
          (failure) => state = BudgetError(failure.toString()),
          (_) => loadBudgets(month),
    );
  }
}

final budgetProvider = StateNotifierProvider<BudgetNotifier, BudgetState>(
      (ref) => BudgetNotifier(ref.watch(budgetRepositoryProvider)),
);