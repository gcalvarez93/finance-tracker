// Path: lib/features/budgets/data/models/budget_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
class BudgetModel with _$BudgetModel {
  const factory BudgetModel({
    required String id,
    required String categoryId,
    String? categoryName,
    String? categoryIcon,
    required double amount,
    @Default(0.0) double spent,
    required String month,
    required DateTime createdAt,
  }) = _BudgetModel;

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);
}