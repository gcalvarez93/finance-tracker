// Path: lib/features/transactions/domain/usecases/export_transactions_usecase.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/export_format.dart';
import '../repositories/i_export_repository.dart';

class ExportTransactionsUseCase {
  final IExportRepository _repository;

  ExportTransactionsUseCase(this._repository);

  Future<Either<Failure, String>> call(ExportFormat format) =>
      _repository.exportTransactions(format);
}