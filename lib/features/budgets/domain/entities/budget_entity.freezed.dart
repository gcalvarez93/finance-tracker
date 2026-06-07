// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BudgetEntity {
  String get id => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  String get categoryIcon => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get spent => throw _privateConstructorUsedError;
  String get month => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetEntityCopyWith<BudgetEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetEntityCopyWith<$Res> {
  factory $BudgetEntityCopyWith(
          BudgetEntity value, $Res Function(BudgetEntity) then) =
      _$BudgetEntityCopyWithImpl<$Res, BudgetEntity>;
  @useResult
  $Res call(
      {String id,
      String categoryId,
      String categoryName,
      String categoryIcon,
      double amount,
      double spent,
      String month,
      DateTime createdAt});
}

/// @nodoc
class _$BudgetEntityCopyWithImpl<$Res, $Val extends BudgetEntity>
    implements $BudgetEntityCopyWith<$Res> {
  _$BudgetEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryIcon = null,
    Object? amount = null,
    Object? spent = null,
    Object? month = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIcon: null == categoryIcon
          ? _value.categoryIcon
          : categoryIcon // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetEntityImplCopyWith<$Res>
    implements $BudgetEntityCopyWith<$Res> {
  factory _$$BudgetEntityImplCopyWith(
          _$BudgetEntityImpl value, $Res Function(_$BudgetEntityImpl) then) =
      __$$BudgetEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String categoryId,
      String categoryName,
      String categoryIcon,
      double amount,
      double spent,
      String month,
      DateTime createdAt});
}

/// @nodoc
class __$$BudgetEntityImplCopyWithImpl<$Res>
    extends _$BudgetEntityCopyWithImpl<$Res, _$BudgetEntityImpl>
    implements _$$BudgetEntityImplCopyWith<$Res> {
  __$$BudgetEntityImplCopyWithImpl(
      _$BudgetEntityImpl _value, $Res Function(_$BudgetEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryIcon = null,
    Object? amount = null,
    Object? spent = null,
    Object? month = null,
    Object? createdAt = null,
  }) {
    return _then(_$BudgetEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIcon: null == categoryIcon
          ? _value.categoryIcon
          : categoryIcon // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$BudgetEntityImpl extends _BudgetEntity {
  const _$BudgetEntityImpl(
      {required this.id,
      required this.categoryId,
      required this.categoryName,
      required this.categoryIcon,
      required this.amount,
      required this.spent,
      required this.month,
      required this.createdAt})
      : super._();

  @override
  final String id;
  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final String categoryIcon;
  @override
  final double amount;
  @override
  final double spent;
  @override
  final String month;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'BudgetEntity(id: $id, categoryId: $categoryId, categoryName: $categoryName, categoryIcon: $categoryIcon, amount: $amount, spent: $spent, month: $month, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryIcon, categoryIcon) ||
                other.categoryIcon == categoryIcon) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, categoryId, categoryName,
      categoryIcon, amount, spent, month, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetEntityImplCopyWith<_$BudgetEntityImpl> get copyWith =>
      __$$BudgetEntityImplCopyWithImpl<_$BudgetEntityImpl>(this, _$identity);
}

abstract class _BudgetEntity extends BudgetEntity {
  const factory _BudgetEntity(
      {required final String id,
      required final String categoryId,
      required final String categoryName,
      required final String categoryIcon,
      required final double amount,
      required final double spent,
      required final String month,
      required final DateTime createdAt}) = _$BudgetEntityImpl;
  const _BudgetEntity._() : super._();

  @override
  String get id;
  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  String get categoryIcon;
  @override
  double get amount;
  @override
  double get spent;
  @override
  String get month;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$BudgetEntityImplCopyWith<_$BudgetEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
