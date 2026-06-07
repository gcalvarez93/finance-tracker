// Path: lib/features/budgets/domain/repositories/i_budget_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/budget_entity.dart';

abstract interface class IBudgetRepository {
  Future<Either<Failure, List<BudgetEntity>>> getBudgets(String month);
  Future<Either<Failure, BudgetEntity>> createBudget({
    required String categoryId,
    required double limit,
    required int month,
    required int year,
  });
  Future<Either<Failure, Unit>> deleteBudget(String id);
}