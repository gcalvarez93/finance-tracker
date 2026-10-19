// Path: lib/features/transactions/domain/repositories/i_export_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/export_format.dart';

abstract interface class IExportRepository {
  /// Exporta los movimientos y devuelve la ruta local del archivo generado.
  Future<Either<Failure, String>> exportTransactions(ExportFormat format);
}