// Path: lib/features/transactions/presentation/providers/transaction_provider.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/export_remote_datasource.dart';
import '../../data/datasources/ocr_remote_datasource.dart';
import '../../data/datasources/transaction_remote_datasource.dart';
import '../../data/repositories/export_repository_impl.dart';
import '../../data/repositories/receipt_scan_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_export_repository.dart';
import '../../domain/repositories/i_receipt_scan_repository.dart';
import '../../domain/repositories/i_transaction_repository.dart';
import '../../domain/usecases/export_transactions_usecase.dart';
import '../../domain/usecases/scan_receipt_usecase.dart';

// Datasource
final transactionDatasourceProvider = Provider<ITransactionRemoteDatasource>(
      (ref) => TransactionRemoteDatasource(ref.watch(dioClientProvider)),
);

// Repository
final transactionRepositoryProvider = Provider<ITransactionRepository>(
      (ref) => TransactionRepositoryImpl(ref.watch(transactionDatasourceProvider)),
);

// OCR
final ocrDatasourceProvider = Provider<IOcrRemoteDatasource>(
      (ref) => OcrRemoteDatasource(ref.watch(dioClientProvider)),
);

final receiptScanRepositoryProvider = Provider<IReceiptScanRepository>(
      (ref) => ReceiptScanRepositoryImpl(ref.watch(ocrDatasourceProvider)),
);

final scanReceiptUseCaseProvider = Provider(
      (ref) => ScanReceiptUseCase(ref.watch(receiptScanRepositoryProvider)),
);

// Exportación
final exportDatasourceProvider = Provider<IExportRemoteDatasource>(
      (ref) => ExportRemoteDatasource(ref.watch(dioClientProvider)),
);

final exportRepositoryProvider = Provider<IExportRepository>(
      (ref) => ExportRepositoryImpl(ref.watch(exportDatasourceProvider)),
);

final exportTransactionsUseCaseProvider = Provider(
      (ref) => ExportTransactionsUseCase(ref.watch(exportRepositoryProvider)),
);

// State
sealed class TransactionState {}
class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  final List<TransactionEntity> transactions;
  final double balance;

  /// Fallo de la última operación (recarga o borrado) que NO invalida los
  /// datos mostrados. La UI lo avisa con un SnackBar y conserva la lista.
  final Failure? actionFailure;

  TransactionLoaded({
    required this.transactions,
    required this.balance,
    this.actionFailure,
  });
}
/// Fallo de carga SIN datos que mostrar (pantalla de error con reintento).
class TransactionError extends TransactionState {
  final Failure failure;
  TransactionError(this.failure);
}

// Notifier
class TransactionNotifier extends StateNotifier<TransactionState> {
  final ITransactionRepository _repository;

  TransactionNotifier(this._repository) : super(TransactionInitial()) {
    loadTransactions();
  }

  /// Carga (o recarga) movimientos y balance.
  ///
  /// Si ya hay datos en pantalla se conservan mientras se recarga y, si la
  /// recarga falla, siguen visibles con [TransactionLoaded.actionFailure].
  /// Solo se pasa a [TransactionLoading] o [TransactionError] cuando no hay
  /// nada que enseñar.
  Future<void> loadTransactions() async {
    if (state is! TransactionLoaded) state = TransactionLoading();

    final transactionsResult = await _repository.getTransactions();
    final balanceResult = await _repository.getBalance();

    final Failure? failure = transactionsResult.fold<Failure?>(
          (f) => f,
          (_) => balanceResult.fold<Failure?>((f) => f, (_) => null),
    );

    final current = state;
    if (failure != null) {
      state = current is TransactionLoaded
          ? TransactionLoaded(
        transactions: current.transactions,
        balance: current.balance,
        actionFailure: failure,
      )
          : TransactionError(failure);
      return;
    }

    transactionsResult.fold<void>(
          (_) {},
          (transactions) {
        balanceResult.fold<void>(
              (_) {},
              (balance) {
            state = TransactionLoaded(
              transactions: transactions,
              balance: balance,
            );
          },
        );
      },
    );
  }

  /// Crea un movimiento. Devuelve `null` si todo fue bien o el [Failure] si
  /// falló. No toca el estado de la lista en caso de fallo: el formulario
  /// decide cómo mostrar el error y conserva lo que escribió el usuario.
  Future<Failure?> createTransaction({
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

    return result.fold<Failure?>(
          (failure) => failure,
          (_) {
        unawaited(loadTransactions());
        return null;
      },
    );
  }

  /// Borra con eliminación optimista: el movimiento desaparece al instante y,
  /// si el servidor falla, se restaura la lista y se avisa del error.
  Future<void> deleteTransaction(String id) async {
    final current = state;
    if (current is! TransactionLoaded) return;

    state = TransactionLoaded(
      transactions: current.transactions.where((t) => t.id != id).toList(),
      balance: current.balance,
    );

    final result = await _repository.deleteTransaction(id);
    result.fold(
          (failure) {
        state = TransactionLoaded(
          transactions: current.transactions,
          balance: current.balance,
          actionFailure: failure,
        );
      },
          (_) {
        unawaited(loadTransactions());
      },
    );
  }
}

final transactionProvider =
StateNotifierProvider<TransactionNotifier, TransactionState>(
      (ref) => TransactionNotifier(ref.watch(transactionRepositoryProvider)),
);