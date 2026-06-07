// Path: lib/features/transactions/domain/entities/transaction_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

@freezed
class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
    required DateTime createdAt,
  }) = _TransactionEntity;
}