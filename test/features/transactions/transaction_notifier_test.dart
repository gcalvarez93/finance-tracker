// Path: test/features/transactions/transaction_notifier_test.dart
import 'package:finance_tracker/core/errors/failures.dart';
import 'package:finance_tracker/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../helpers/fakes.dart';

void main() {
  late FakeTransactionRepository repository;

  setUp(() => repository = FakeTransactionRepository());

  Future<TransactionNotifier> buildNotifier() async {
    final notifier = TransactionNotifier(repository);
    await pumpEventQueue();
    return notifier;
  }

  group('carga inicial', () {
    test('expone movimientos y balance cuando todo va bien', () async {
      repository
        ..transactionsResult = right([testTransaction])
        ..balanceResult = right(87.5);

      final notifier = await buildNotifier();

      final state = notifier.state;
      expect(state, isA<TransactionLoaded>());
      state as TransactionLoaded;
      expect(state.transactions, [testTransaction]);
      expect(state.balance, 87.5);
    });

    test('pasa a error si falla la lista de movimientos', () async {
      repository.transactionsResult =
          left(const Failure.server(message: 'boom'));

      final notifier = await buildNotifier();

      expect(notifier.state, isA<TransactionError>());
    });

    test('pasa a error si falla el balance', () async {
      repository.balanceResult = left(const Failure.network(message: 'sin red'));

      final notifier = await buildNotifier();

      expect(notifier.state, isA<TransactionError>());
    });
  });

  group('createTransaction', () {
    test('recarga los movimientos tras crear', () async {
      final notifier = await buildNotifier();
      final callsBefore = repository.getTransactionsCalls;

      await notifier.createTransaction(
        amount: 12.5,
        type: 'expense',
        categoryId: 'c1',
        description: 'Café',
        date: DateTime(2026, 1, 10),
      );
      await pumpEventQueue();

      expect(repository.getTransactionsCalls, callsBefore + 1);
      expect(notifier.state, isA<TransactionLoaded>());
    });

    test('pasa a error si el repositorio falla', () async {
      repository.createResult = left(const Failure.server(message: 'boom'));
      final notifier = await buildNotifier();

      await notifier.createTransaction(
        amount: 1,
        type: 'expense',
        categoryId: 'c1',
        description: 'x',
        date: DateTime(2026, 1, 10),
      );

      expect(notifier.state, isA<TransactionError>());
    });
  });

  group('deleteTransaction', () {
    test('borra por id y recarga', () async {
      final notifier = await buildNotifier();
      final callsBefore = repository.getTransactionsCalls;

      await notifier.deleteTransaction('t1');
      await pumpEventQueue();

      expect(repository.deletedId, 't1');
      expect(repository.getTransactionsCalls, callsBefore + 1);
    });

    test('pasa a error si el borrado falla', () async {
      repository.deleteResult = left(const Failure.server(message: 'boom'));
      final notifier = await buildNotifier();

      await notifier.deleteTransaction('t1');

      expect(notifier.state, isA<TransactionError>());
    });
  });
}