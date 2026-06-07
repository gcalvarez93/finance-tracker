// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  type: json['type'] as String,
  categoryId: json['categoryId'] as String,
  description: json['description'] as String,
  date: DateTime.parse(json['date'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'type': instance.type,
  'categoryId': instance.categoryId,
  'description': instance.description,
  'date': instance.date.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
};
