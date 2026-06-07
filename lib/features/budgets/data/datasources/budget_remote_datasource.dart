// Path: lib/features/budgets/data/datasources/budget_remote_datasource.dart
import '../../../../core/config/api_config.dart';
import '../../../../core/network/dio_client.dart';
import '../models/budget_model.dart';

abstract interface class IBudgetRemoteDatasource {
  Future<List<BudgetModel>> getBudgets(String month);
  Future<BudgetModel> createBudget({
    required String categoryId,
    required double limit,
    required int month,
    required int year,
  });
  Future<void> deleteBudget(String id);
}

class BudgetRemoteDatasource implements IBudgetRemoteDatasource {
  final DioClient _client;

  BudgetRemoteDatasource(this._client);

  @override
  Future<List<BudgetModel>> getBudgets(String month) async {
    final response = await _client.get(
      ApiConfig.budgets,
      params: {'month': month},
    );
    final List data = response.data as List;
    return data.map((e) => BudgetModel.fromJson(e)).toList();
  }

  @override
  Future<BudgetModel> createBudget({
    required String categoryId,
    required double limit,
    required int month,
    required int year,
  }) async {
    final monthStr = '$year-${month.toString().padLeft(2, '0')}';
    final response = await _client.post(ApiConfig.budgets, data: {
      'categoryId': categoryId,
      'amount': limit,
      'month': monthStr,
    });
    return BudgetModel.fromJson(response.data);
  }

  @override
  Future<void> deleteBudget(String id) async {
    await _client.delete('${ApiConfig.budgets}/$id');
  }
}