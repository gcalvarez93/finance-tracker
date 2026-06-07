// Path: lib/features/transactions/domain/repositories/i_transaction_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';

abstract interface class ITransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransactions();
  Future<Either<Failure, double>> getBalance();
  Future<Either<Failure, TransactionEntity>> createTransaction({
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
  });
  Future<Either<Failure, Unit>> deleteTransaction(String id);
}