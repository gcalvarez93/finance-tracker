// Path: lib/features/categories/domain/repositories/i_category_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, CategoryEntity>> createCategory({
    required String name,
    required String color,
    required String icon,
  });
  Future<Either<Failure, CategoryEntity>> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  });
  Future<Either<Failure, Unit>> deleteCategory(String id);
}