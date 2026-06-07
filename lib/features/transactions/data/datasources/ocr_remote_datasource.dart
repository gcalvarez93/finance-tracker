// Path: lib/features/transactions/data/datasources/ocr_remote_datasource.dart
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/config/api_config.dart';
import '../../../../core/network/dio_client.dart';

class OcrResult {
  final double? amount;
  final String? description;
  final DateTime? date;

  const OcrResult({this.amount, this.description, this.date});

  factory OcrResult.fromJson(Map<String, dynamic> json) => OcrResult(
    amount: (json['amount'] as num?)?.toDouble(),
    description: json['description'] as String?,
    date: json['date'] != null ? DateTime.tryParse(json['date'] as String) : null,
  );
}

abstract interface class IOcrRemoteDatasource {
  Future<OcrResult> scanReceipt(File image);
}

class OcrRemoteDatasource implements IOcrRemoteDatasource {
  final DioClient _client;

  OcrRemoteDatasource(this._client);

  @override
  Future<OcrResult> scanReceipt(File image) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path, filename: 'receipt.jpg'),
    });

    final response = await _client.post(
      ApiConfig.transactionsScanReceipt,
      data: formData,
    );

    return OcrResult.fromJson(response.data as Map<String, dynamic>);
  }
}