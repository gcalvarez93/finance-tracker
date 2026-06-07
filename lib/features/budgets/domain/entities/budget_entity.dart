// Path: lib/features/budgets/domain/entities/budget_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_entity.freezed.dart';

@freezed
class BudgetEntity with _$BudgetEntity {
  const factory BudgetEntity({
    required String id,
    required String categoryId,
    required String categoryName,
    required String categoryIcon,
    required double amount,
    required double spent,
    required String month,
    required DateTime createdAt,
  }) = _BudgetEntity;

  const BudgetEntity._();

  double get remaining => amount - spent;
  double get percentage => spent / amount;
  bool get isOverBudget => spent > amount;
}