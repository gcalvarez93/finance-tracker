// Path: lib/features/profile/domain/entities/profile_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    required String name,
    required String email,
    String? photoUrl,
    required String language,
    required bool notifications,
    required bool notificationsGeneral,
    required bool notificationsTransactions,
    required bool notificationsBudgets,
    required bool notificationsReports,
  }) = _ProfileEntity;
}