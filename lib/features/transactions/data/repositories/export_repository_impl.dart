// Path: lib/features/transactions/data/repositories/export_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/export_format.dart';
import '../../domain/repositories/i_export_repository.dart';
import '../datasources/export_remote_datasource.dart';

class ExportRepositoryImpl implements IExportRepository {
  final IExportRemoteDatasource _datasource;

  ExportRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, String>> exportTransactions(
      ExportFormat format,
      ) async {
    try {
      final path = switch (format) {
        ExportFormat.pdf => await _datasource.exportPdf(),
        ExportFormat.excel => await _datasource.exportExcel(),
      };
      return right(path);
    } catch (e, st) {
      AppLogger.error('ExportRepositoryImpl.exportTransactions', e, st);
      return left(Failure.server(message: e.toString()));
    }
  }
}