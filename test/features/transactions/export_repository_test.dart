// Path: test/features/transactions/export_repository_test.dart
import 'package:finance_tracker/features/transactions/data/datasources/export_remote_datasource.dart';
import 'package:finance_tracker/features/transactions/data/repositories/export_repository_impl.dart';
import 'package:finance_tracker/features/transactions/domain/entities/export_format.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeExportDatasource implements IExportRemoteDatasource {
  bool fail = false;
  final calls = <String>[];

  @override
  Future<String> exportPdf() async {
    calls.add('pdf');
    if (fail) throw Exception('boom');
    return '/tmp/export.pdf';
  }

  @override
  Future<String> exportExcel() async {
    calls.add('excel');
    if (fail) throw Exception('boom');
    return '/tmp/export.xlsx';
  }
}

void main() {
  late _FakeExportDatasource datasource;
  late ExportRepositoryImpl repository;

  setUp(() {
    datasource = _FakeExportDatasource();
    repository = ExportRepositoryImpl(datasource);
  });

  test('usa el datasource de PDF para ExportFormat.pdf', () async {
    final result = await repository.exportTransactions(ExportFormat.pdf);

    expect(datasource.calls, ['pdf']);
    expect(result.getOrElse((_) => ''), '/tmp/export.pdf');
  });

  test('usa el datasource de Excel para ExportFormat.excel', () async {
    final result = await repository.exportTransactions(ExportFormat.excel);

    expect(datasource.calls, ['excel']);
    expect(result.getOrElse((_) => ''), '/tmp/export.xlsx');
  });

  test('devuelve Failure si la exportación falla', () async {
    datasource.fail = true;

    final result = await repository.exportTransactions(ExportFormat.pdf);

    expect(result.isLeft(), isTrue);
  });
}