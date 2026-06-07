// Path: lib/features/transactions/data/datasources/export_remote_datasource.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/config/api_config.dart';
import '../../../../core/network/dio_client.dart';

abstract interface class IExportRemoteDatasource {
  Future<String> exportPdf();
  Future<String> exportExcel();
}

class ExportRemoteDatasource implements IExportRemoteDatasource {
  final DioClient _client;

  ExportRemoteDatasource(this._client);

  @override
  Future<String> exportPdf() => _downloadFile(
    url: ApiConfig.transactionsExportPdf,
    filename: 'transacciones_${DateTime.now().millisecondsSinceEpoch}.pdf',
  );

  @override
  Future<String> exportExcel() => _downloadFile(
    url: ApiConfig.transactionsExportExcel,
    filename: 'transacciones_${DateTime.now().millisecondsSinceEpoch}.xlsx',
  );

  Future<String> _downloadFile({
    required String url,
    required String filename,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$filename';

    await _client.download(url, path);
    return path;
  }
}