// Path: lib/features/categories/data/datasources/category_remote_datasource.dart
import '../../../../core/config/api_config.dart';
import '../../../../core/network/dio_client.dart';
import '../models/category_model.dart';

abstract interface class ICategoryRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> createCategory({
    required String name,
    required String color,
    required String icon,
  });
  Future<CategoryModel> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  });
  Future<void> deleteCategory(String id);
}

class CategoryRemoteDatasource implements ICategoryRemoteDatasource {
  final DioClient _client;

  CategoryRemoteDatasource(this._client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _client.get(ApiConfig.categories);
    final List data = response.data as List;
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<CategoryModel> createCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    final response = await _client.post(ApiConfig.categories, data: {
      'name': name,
      'color': color,
      'icon': icon,
    });
    return CategoryModel.fromJson(response.data);
  }

  @override
  Future<CategoryModel> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  }) async {
    final response = await _client.put('${ApiConfig.categories}/$id', data: {
      'name': name,
      'color': color,
      'icon': icon,
    });
    return CategoryModel.fromJson(response.data);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _client.delete('${ApiConfig.categories}/$id');
  }
}