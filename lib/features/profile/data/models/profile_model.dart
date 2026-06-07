// Path: lib/features/profile/data/models/profile_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
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
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}