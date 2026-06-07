// Path: lib/features/transactions/presentation/providers/transaction_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/transaction_remote_datasource.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_transaction_repository.dart';

// Datasource
final transactionDatasourceProvider = Provider<ITransactionRemoteDatasource>(
      (ref) => TransactionRemoteDatasource(ref.watch(dioClientProvider)),
);

// Repository
final transactionRepositoryProvider = Provider<ITransactionRepository>(
      (ref) => TransactionRepositoryImpl(ref.watch(transactionDatasourceProvider)),
);

// State
sealed class TransactionState {}
class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  final double balance;
  TransactionLoaded({required this.transactions, required this.balance});
}
class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
}

// Notifier
class TransactionNotifier extends StateNotifier<TransactionState> {
  final ITransactionRepository _repository;

  TransactionNotifier(this._repository) : super(TransactionInitial()) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    state = TransactionLoading();

    final transactionsResult = await _repository.getTransactions();
    final balanceResult = await _repository.getBalance();

    transactionsResult.fold(
          (failure) => state = TransactionError(failure.toString()),
          (transactions) => balanceResult.fold(
            (failure) => state = TransactionError(failure.toString()),
            (balance) => state = TransactionLoaded(
          transactions: transactions,
          balance: balance,
        ),
      ),
    );
  }

  Future<void> createTransaction({
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
  }) async {
    final result = await _repository.createTransaction(
      amount: amount,
      type: type,
      categoryId: categoryId,
      description: description,
      date: date,
    );

    result.fold(
          (failure) => state = TransactionError(failure.toString()),
          (_) => loadTransactions(),
    );
  }

  Future<void> deleteTransaction(String id) async {
    final result = await _repository.deleteTransaction(id);
    result.fold(
          (failure) => state = TransactionError(failure.toString()),
          (_) => loadTransactions(),
    );
  }
}

final transactionProvider =
StateNotifierProvider<TransactionNotifier, TransactionState>(
      (ref) => TransactionNotifier(ref.watch(transactionRepositoryProvider)),
);