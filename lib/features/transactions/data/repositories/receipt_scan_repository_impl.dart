// Path: lib/features/transactions/data/repositories/receipt_scan_repository_impl.dart
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/receipt_scan_entity.dart';
import '../../domain/repositories/i_receipt_scan_repository.dart';
import '../../data/datasources/ocr_remote_datasource.dart';

class ReceiptScanRepositoryImpl implements IReceiptScanRepository {
  final IOcrRemoteDatasource _datasource;

  ReceiptScanRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, ReceiptScanEntity>> scanReceipt(
      String imagePath,
      ) async {
    try {
      final result = await _datasource.scanReceipt(File(imagePath));
      return right(
        ReceiptScanEntity(
          amount: result.amount,
          description: result.description,
          date: result.date,
        ),
      );
    } catch (e, st) {
      AppLogger.error('ReceiptScanRepositoryImpl.scanReceipt', e, st);
      return left(Failure.server(message: e.toString()));
    }
  }
}