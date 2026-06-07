// Path: lib/features/transactions/data/datasources/transaction_remote_datasource.dart
import '../../../../core/network/dio_client.dart';
import '../../../../core/config/api_config.dart';
import '../models/transaction_model.dart';

abstract interface class ITransactionRemoteDatasource {
  Future<List<TransactionModel>> getTransactions();
  Future<double> getBalance();
  Future<TransactionModel> createTransaction({
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
  });
  Future<void> deleteTransaction(String id);
}

class TransactionRemoteDatasource implements ITransactionRemoteDatasource {
  final DioClient _client;

  TransactionRemoteDatasource(this._client);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final response = await _client.get(ApiConfig.transactions);
    final List data = response.data as List;
    return data.map((e) => TransactionModel.fromJson(e)).toList();
  }

  @override
  Future<double> getBalance() async {
    final response = await _client.get(ApiConfig.transactionsBalance);
    return (response.data as num).toDouble();
  }

  @override
  Future<TransactionModel> createTransaction({
    required double amount,
    required String type,
    required String categoryId,
    required String description,
    required DateTime date,
  }) async {
    final response = await _client.post(ApiConfig.transactions, data: {
      'amount': amount,
      'type': type,
      'categoryId': categoryId,
      'description': description,
      'date': date.toIso8601String(),
    });
    return TransactionModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await _client.delete('${ApiConfig.transactions}/$id');
  }
}