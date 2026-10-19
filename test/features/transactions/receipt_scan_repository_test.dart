// Path: test/features/transactions/receipt_scan_repository_test.dart
import 'dart:io';

import 'package:finance_tracker/features/transactions/data/datasources/ocr_remote_datasource.dart';
import 'package:finance_tracker/features/transactions/data/repositories/receipt_scan_repository_impl.dart';
import 'package:finance_tracker/features/transactions/domain/entities/receipt_scan_entity.dart';
import 'package:finance_tracker/features/transactions/domain/usecases/scan_receipt_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeOcrDatasource implements IOcrRemoteDatasource {
  OcrResult? result;
  Object? error;
  String? receivedPath;

  @override
  Future<OcrResult> scanReceipt(File image) async {
    receivedPath = image.path;
    if (error != null) throw error!;
    return result!;
  }
}

void main() {
  late _FakeOcrDatasource datasource;
  late ScanReceiptUseCase useCase;

  setUp(() {
    datasource = _FakeOcrDatasource();
    useCase = ScanReceiptUseCase(ReceiptScanRepositoryImpl(datasource));
  });

  test('mapea el resultado del OCR a la entidad de dominio', () async {
    datasource.result = OcrResult(
      amount: 9.99,
      description: 'Supermercado',
      date: DateTime(2026, 2, 3),
    );

    final result = await useCase('/tmp/ticket.jpg');

    expect(datasource.receivedPath, '/tmp/ticket.jpg');
    final ReceiptScanEntity? scan = result.fold((_) => null, (s) => s);
    expect(scan, isNotNull);
    expect(scan!.amount, 9.99);
    expect(scan.description, 'Supermercado');
    expect(scan.date, DateTime(2026, 2, 3));
  });

  test('admite lecturas parciales', () async {
    datasource.result = const OcrResult(amount: 5);

    final result = await useCase('/tmp/ticket.jpg');

    final ReceiptScanEntity? scan = result.fold((_) => null, (s) => s);
    expect(scan!.amount, 5);
    expect(scan.description, isNull);
    expect(scan.date, isNull);
  });

  test('devuelve Failure cuando el datasource lanza', () async {
    datasource.error = Exception('timeout');

    final result = await useCase('/tmp/ticket.jpg');

    expect(result.isLeft(), isTrue);
  });
}