// Path: lib/features/auth/domain/usecases/update_display_name_usecase.dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/repositories/i_auth_repository.dart';

class UpdateDisplayNameUseCase {
  final IAuthRepository _repository;

  UpdateDisplayNameUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(String name) =>
      _repository.updateDisplayName(name);
}