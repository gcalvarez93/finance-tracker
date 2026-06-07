// Path: lib/features/budgets/data/repositories/budget_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/budget_entity.dart';
import '../../domain/repositories/i_budget_repository.dart';
import '../datasources/budget_remote_datasource.dart';
import '../models/budget_model.dart';

class BudgetRepositoryImpl implements IBudgetRepository {
  final IBudgetRemoteDatasource _datasource;

  BudgetRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<BudgetEntity>>> getBudgets(String month) async {
    try {
      final models = await _datasource.getBudgets(month);
      return right(models.map(_mapToEntity).toList());
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BudgetEntity>> createBudget({
    required String categoryId,
    required double limit,
    required int month,
    required int year,
  }) async {
    try {
      final model = await _datasource.createBudget(
        categoryId: categoryId,
        limit: limit,
        month: month,
        year: year,
      );
      return right(_mapToEntity(model));
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBudget(String id) async {
    try {
      await _datasource.deleteBudget(id);
      return right(unit);
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  BudgetEntity _mapToEntity(BudgetModel model) => BudgetEntity(
    id: model.id,
    categoryId: model.categoryId,
    categoryName: model.categoryName ?? '',
    categoryIcon: model.categoryIcon ?? '💰',
    amount: model.amount,
    spent: model.spent,
    month: model.month,
    createdAt: model.createdAt,
  );
}