// Path: lib/features/transactions/domain/repositories/i_receipt_scan_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/receipt_scan_entity.dart';

abstract interface class IReceiptScanRepository {
  /// Lee el ticket de la imagen en [imagePath] y devuelve los datos extraídos.
  Future<Either<Failure, ReceiptScanEntity>> scanReceipt(String imagePath);
}