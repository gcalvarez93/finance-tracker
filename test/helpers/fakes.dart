// Path: test/helpers/fakes.dart
import 'package:finance_tracker/core/errors/failures.dart';
import 'package:finance_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:finance_tracker/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:finance_tracker/features/transactions/domain/entities/transaction_entity.dart';
import 'package:finance_tracker/features/transactions/domain/repositories/i_transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

final testTransaction = TransactionEntity(
  id: 't1',
  amount: 12.5,
  type: 'expense',
  categoryId: 'c1',
  description: 'Café',
  date: DateTime(2026, 1, 10),
  createdAt: DateTime(2026, 1, 10),
);

const testUser = UserEntity(id: 'u1', email: 'a@b.com', name: 'Ana');

/// Repositorio de transacciones en memoria con resultados configurables.
class FakeTransactionRepository implements ITransactionRepository {
  Either<Failure, List<TransactionEntity>> transactionsResult =
  right(<TransactionEntity>[]);
  Either<Failure, double> balanceResult = right(0);
  Either<Failure, TransactionEntity>? createResult;
  Either<Failure, Unit> deleteResult = right(unit);

  int getTransactionsCalls = 0;
  String? deletedId;

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {
    getTransactionsCalls++;
    return transactionsResult;
  }

  @override
  Future<Either<Failure, double>> getBalance() async => balanceResult;

  @override
  Future<Either<Failure, TransactionEntity>> createTransaction({
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
  }) async =>
      createResult ?? right(testTransaction);

  @override
  Future<Either<Failure, Unit>> deleteTransaction(String id) async {
    deletedId = id;
    return deleteResult;
  }
}

/// Repositorio de autenticación en memoria con resultados configurables.
class FakeAuthRepository implements IAuthRepository {
  UserEntity? currentUser;
  Either<Failure, UserEntity> loginResult = right(testUser);
  Either<Failure, UserEntity> updateNameResult = right(testUser);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  }) async =>
      loginResult;

  @override
  Future<Either<Failure, UserEntity>> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async =>
      loginResult;

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async => loginResult;

  @override
  Future<Either<Failure, Unit>> logout() async {
    currentUser = null;
    return right(unit);
  }

  @override
  Future<Either<Failure, UserEntity>> updateDisplayName(String name) async =>
      updateNameResult;

  @override
  UserEntity? getCurrentUser() => currentUser;
}