// Path: lib/features/categories/domain/entities/category_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String name,
    required String color,
    required String icon,
    required DateTime createdAt,
  }) = _CategoryEntity;
}