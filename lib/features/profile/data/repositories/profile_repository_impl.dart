// Path: lib/features/profile/data/repositories/profile_repository_impl.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/i_profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final model = await _datasource.getProfile();
      return right(_mapToEntity(model));
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String language,
    required bool notifications,
    required bool notificationsGeneral,
    required bool notificationsTransactions,
    required bool notificationsBudgets,
    required bool notificationsReports,
  }) async {
    try {
      final model = await _datasource.updateProfile(
        name: name,
        language: language,
        notifications: notifications,
        notificationsGeneral: notificationsGeneral,
        notificationsTransactions: notificationsTransactions,
        notificationsBudgets: notificationsBudgets,
        notificationsReports: notificationsReports,
      );
      return right(_mapToEntity(model));
    } catch (e) {
      return left(Failure.server(message: e.toString()));
    }
  }

  ProfileEntity _mapToEntity(ProfileModel model) => ProfileEntity(
    id: model.id,
    name: model.name,
    email: model.email,
    photoUrl: model.photoUrl,
    language: model.language,
    notifications: model.notifications,
    notificationsGeneral: model.notificationsGeneral,
    notificationsTransactions: model.notificationsTransactions,
    notificationsBudgets: model.notificationsBudgets,
    notificationsReports: model.notificationsReports,
  );
}