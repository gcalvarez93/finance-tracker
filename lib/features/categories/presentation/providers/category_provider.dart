// Path: lib/features/categories/presentation/providers/category_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/category_remote_datasource.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/i_category_repository.dart';

// Datasource
final categoryDatasourceProvider = Provider<ICategoryRemoteDatasource>(
      (ref) => CategoryRemoteDatasource(ref.watch(dioClientProvider)),
);

// Repository
final categoryRepositoryProvider = Provider<ICategoryRepository>(
      (ref) => CategoryRepositoryImpl(ref.watch(categoryDatasourceProvider)),
);

// State
sealed class CategoryState {}
class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}
class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  CategoryLoaded(this.categories);
}
class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

// Notifier
class CategoryNotifier extends StateNotifier<CategoryState> {
  final ICategoryRepository _repository;

  CategoryNotifier(this._repository) : super(CategoryInitial()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = CategoryLoading();
    final result = await _repository.getCategories();
    result.fold(
          (failure) => state = CategoryError(failure.toString()),
          (categories) => state = CategoryLoaded(categories),
    );
  }

  Future<void> createCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    final result = await _repository.createCategory(
      name: name,
      color: color,
      icon: icon,
    );
    result.fold(
          (failure) => state = CategoryError(failure.toString()),
          (_) => loadCategories(),
    );
  }

  Future<void> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  }) async {
    final result = await _repository.updateCategory(
      id: id,
      name: name,
      color: color,
      icon: icon,
    );
    result.fold(
          (failure) => state = CategoryError(failure.toString()),
          (_) => loadCategories(),
    );
  }

  Future<void> deleteCategory(String id) async {
    final result = await _repository.deleteCategory(id);
    result.fold(
          (failure) => state = CategoryError(failure.toString()),
          (_) => loadCategories(),
    );
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>(
      (ref) => CategoryNotifier(ref.watch(categoryRepositoryProvider)),
);