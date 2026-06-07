// Path: lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _datasource.loginWithEmail(
        email: email,
        password: password,
      );
      return right(_mapToEntity(credential.user!));
    } on FirebaseAuthException catch (e) {
      return left(Failure.auth(message: e.message ?? 'Error de autenticación'));
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _datasource.registerWithEmail(
        email: email,
        password: password,
        name: name,
      );
      return right(_mapToEntity(credential.user!));
    } on FirebaseAuthException catch (e) {
      return left(Failure.auth(message: e.message ?? 'Error de registro'));
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final credential = await _datasource.loginWithGoogle();
      return right(_mapToEntity(credential.user!));
    } on FirebaseAuthException catch (e) {
      return left(Failure.auth(message: e.message ?? 'Error con Google'));
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _datasource.logout();
      return right(unit);
    } catch (e) {
      return left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  UserEntity? getCurrentUser() {
    final user = _datasource.getCurrentUser();
    if (user == null) return null;
    return _mapToEntity(user);
  }

  UserEntity _mapToEntity(User user) => UserEntity(
    id: user.uid,
    email: user.email ?? '',
    name: user.displayName,
    photoUrl: user.photoURL,
  );
}