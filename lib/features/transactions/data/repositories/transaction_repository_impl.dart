// Path: lib/features/transactions/data/repositories/transaction_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_transaction_repository.dart';
import '../datasources/transaction_remote_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  final ITransactionRemoteDatasource _datasource;

  TransactionRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {
    try {
      final models = await _datasource.getTransactions();
      return right(models.map(_mapToEntity).toList());
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getBalance() async {
    try {
      final balance = await _datasource.getBalance();
      return right(balance);
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> createTransaction({
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
  }) async {
    try {
      final model = await _datasource.createTransaction(
        amount: amount,
        type: type,
        categoryId: categoryId,
        description: description,
        date: date,
      );
      return right(_mapToEntity(model));
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTransaction(String id) async {
    try {
      await _datasource.deleteTransaction(id);
      return right(unit);
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  TransactionEntity _mapToEntity(TransactionModel model) => TransactionEntity(
    id: model.id,
    amount: model.amount,
    type: model.type,
    categoryId: model.categoryId,
    description: model.description,
    date: model.date,
    createdAt: model.createdAt,
  );
}