// Path: lib/features/categories/presentation/providers/category_provider.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import 'package:fpdart/fpdart.dart';
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
  final Failure failure;
  CategoryError(this.failure);
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
          (failure) => state = CategoryError(failure),
          (categories) => state = CategoryLoaded(categories),
    );
  }

  /// Devuelve `null` si se creó o el [Failure] si falló (no toca la lista).
  Future<Failure?> createCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    final result = await _repository.createCategory(
      name: name,
      color: color,
      icon: icon,
    );
    return _reloadOnSuccess(result);
  }

  /// Devuelve `null` si se actualizó o el [Failure] si falló (no toca la lista).
  Future<Failure?> updateCategory({
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
    return _reloadOnSuccess(result);
  }

  /// Devuelve `null` si se borró o el [Failure] si falló. En ambos casos
  /// recarga para que la lista refleje lo que hay en el servidor.
  Future<Failure?> deleteCategory(String id) async {
    final result = await _repository.deleteCategory(id);
    unawaited(loadCategories());
    return result.fold<Failure?>((failure) => failure, (_) => null);
  }

  Failure? _reloadOnSuccess(Either<Failure, Object?> result) {
    return result.fold<Failure?>(
          (failure) => failure,
          (_) {
        unawaited(loadCategories());
        return null;
      },
    );
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>(
      (ref) => CategoryNotifier(ref.watch(categoryRepositoryProvider)),
);