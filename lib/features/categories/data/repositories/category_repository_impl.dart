// Path: lib/features/categories/data/repositories/category_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/i_category_repository.dart';
import '../datasources/category_remote_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  final ICategoryRemoteDatasource _datasource;

  CategoryRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final models = await _datasource.getCategories();
      return right(models.map(_mapToEntity).toList());
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> createCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    try {
      final model = await _datasource.createCategory(
        name: name,
        color: color,
        icon: icon,
      );
      return right(_mapToEntity(model));
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  }) async {
    try {
      final model = await _datasource.updateCategory(
        id: id,
        name: name,
        color: color,
        icon: icon,
      );
      return right(_mapToEntity(model));
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(String id) async {
    try {
      await _datasource.deleteCategory(id);
      return right(unit);
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  CategoryEntity _mapToEntity(CategoryModel model) => CategoryEntity(
    id: model.id,
    name: model.name,
    color: model.color,
    icon: model.icon,
    createdAt: model.createdAt,
  );
}