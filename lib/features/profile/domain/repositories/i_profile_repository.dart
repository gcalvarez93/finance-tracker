// Path: lib/features/profile/domain/repositories/i_profile_repository.dart
// Path: lib/features/profile/domain/repositories/i_profile_repository.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/profile_entity.dart';

abstract interface class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String language,
    required bool notifications,
    required bool notificationsGeneral,
    required bool notificationsTransactions,
    required bool notificationsBudgets,
    required bool notificationsReports,
  });
}