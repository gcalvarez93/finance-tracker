// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetModelImpl _$$BudgetModelImplFromJson(Map<String, dynamic> json) =>
    _$BudgetModelImpl(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String?,
      categoryIcon: json['categoryIcon'] as String?,
      amount: (json['amount'] as num).toDouble(),
      spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
      month: json['month'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BudgetModelImplToJson(_$BudgetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryIcon': instance.categoryIcon,
      'amount': instance.amount,
      'spent': instance.spent,
      'month': instance.month,
      'createdAt': instance.createdAt.toIso8601String(),
    };
