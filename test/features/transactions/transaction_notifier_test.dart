// Path: test/features/transactions/transaction_notifier_test.dart
import 'package:finance_tracker/core/errors/failures.dart';
import 'package:finance_tracker/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../helpers/fakes.dart';

void main() {
  late FakeTransactionRepository repository;

  const boom = Failure.server(message: 'boom');

  setUp(() => repository = FakeTransactionRepository());

  Future<TransactionNotifier> buildNotifier() async {
    final notifier = TransactionNotifier(repository);
    await pumpEventQueue();
    return notifier;
  }

  Future<TransactionNotifier> buildLoadedNotifier() async {
    repository
      ..transactionsResult = right([testTransaction])
      ..balanceResult = right(87.5);
    return buildNotifier();
  }

  group('carga inicial', () {
    test('expone movimientos y balance cuando todo va bien', () async {
      final notifier = await buildLoadedNotifier();

      final state = notifier.state;
      expect(state, isA<TransactionLoaded>());
      state as TransactionLoaded;
      expect(state.transactions, [testTransaction]);
      expect(state.balance, 87.5);
      expect(state.actionFailure, isNull);
    });

    test('pasa a error con el Failure si falla la lista de movimientos',
            () async {
          repository.transactionsResult = left(boom);

          final notifier = await buildNotifier();

          final state = notifier.state;
          expect(state, isA<TransactionError>());
          expect((state as TransactionError).failure, boom);
        });

    test('pasa a error con el Failure si falla el balance', () async {
      const offline = Failure.network(message: 'sin red');
      repository.balanceResult = left(offline);

      final notifier = await buildNotifier();

      final state = notifier.state;
      expect(state, isA<TransactionError>());
      expect((state as TransactionError).failure, offline);
    });

    test('desde el error, reintentar vuelve a cargar los datos', () async {
      repository.transactionsResult = left(boom);
      final notifier = await buildNotifier();
      expect(notifier.state, isA<TransactionError>());

      repository.transactionsResult = right([testTransaction]);
      await notifier.loadTransactions();

      expect(notifier.state, isA<TransactionLoaded>());
    });
  });

  group('recarga con datos en pantalla', () {
    test('no pasa por Loading: la lista se mantiene mientras recarga',
            () async {
          final notifier = await buildLoadedNotifier();
          final states = <TransactionState>[];
          final remove = notifier.addListener(states.add, fireImmediately: false);

          await notifier.loadTransactions();
          remove();

          expect(states.whereType<TransactionLoading>(), isEmpty);
          expect(states.last, isA<TransactionLoaded>());
        });

    test('si la recarga falla conserva la lista y expone el fallo', () async {
      final notifier = await buildLoadedNotifier();

      repository.transactionsResult = left(boom);
      await notifier.loadTransactions();

      final state = notifier.state;
      expect(state, isA<TransactionLoaded>());
      state as TransactionLoaded;
      expect(state.transactions, [testTransaction]);
      expect(state.balance, 87.5);
      expect(state.actionFailure, boom);
    });

    test('una recarga correcta limpia el fallo anterior', () async {
      final notifier = await buildLoadedNotifier();
      repository.transactionsResult = left(boom);
      await notifier.loadTransactions();

      repository.transactionsResult = right([testTransaction]);
      await notifier.loadTransactions();

      expect((notifier.state as TransactionLoaded).actionFailure, isNull);
    });
  });

  group('createTransaction', () {
    Future<Failure?> create(TransactionNotifier notifier) =>
        notifier.createTransaction(
          amount: 12.5,
          type: 'expense',
          categoryId: 'c1',
          description: 'Café',
          date: DateTime(2026, 1, 10),
        );

    test('devuelve null y recarga los movimientos tras crear', () async {
      final notifier = await buildNotifier();
      final callsBefore = repository.getTransactionsCalls;

      final failure = await create(notifier);
      await pumpEventQueue();

      expect(failure, isNull);
      expect(repository.getTransactionsCalls, callsBefore + 1);
      expect(notifier.state, isA<TransactionLoaded>());
    });

    test('si falla devuelve el Failure y NO toca la lista', () async {
      repository.createResult = left(boom);
      final notifier = await buildLoadedNotifier();
      final stateBefore = notifier.state;
      final callsBefore = repository.getTransactionsCalls;

      final failure = await create(notifier);
      await pumpEventQueue();

      expect(failure, boom);
      expect(identical(notifier.state, stateBefore), isTrue);
      expect(repository.getTransactionsCalls, callsBefore);
    });
  });

  group('deleteTransaction', () {
    test('borra por id y recarga', () async {
      final notifier = await buildLoadedNotifier();
      final callsBefore = repository.getTransactionsCalls;

      await notifier.deleteTransaction('t1');
      await pumpEventQueue();

      expect(repository.deletedId, 't1');
      expect(repository.getTransactionsCalls, callsBefore + 1);
    });

    test('si el borrado falla restaura la lista y expone el fallo', () async {
      repository.deleteResult = left(boom);
      final notifier = await buildLoadedNotifier();

      await notifier.deleteTransaction('t1');

      final state = notifier.state;
      expect(state, isA<TransactionLoaded>());
      state as TransactionLoaded;
      expect(state.transactions, [testTransaction]);
      expect(state.actionFailure, boom);
    });

    test('sin datos cargados no hace nada', () async {
      repository.transactionsResult = left(boom);
      final notifier = await buildNotifier();

      await notifier.deleteTransaction('t1');

      expect(repository.deletedId, isNull);
      expect(notifier.state, isA<TransactionError>());
    });
  });
}