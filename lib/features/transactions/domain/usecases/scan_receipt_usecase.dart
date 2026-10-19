// Path: lib/features/transactions/domain/usecases/scan_receipt_usecase.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/receipt_scan_entity.dart';
import '../repositories/i_receipt_scan_repository.dart';

class ScanReceiptUseCase {
  final IReceiptScanRepository _repository;

  ScanReceiptUseCase(this._repository);

  Future<Either<Failure, ReceiptScanEntity>> call(String imagePath) =>
      _repository.scanReceipt(imagePath);
}