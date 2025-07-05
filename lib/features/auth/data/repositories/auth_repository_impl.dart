import 'package:dartz/dartz.dart';
import 'package:vikn_task/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vikn_task/features/auth/domain/usecase/login_usecase.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final SecureStorage storage;

  AuthRepositoryImpl({
    required this.remote,
    required this.storage,
  });

  @override
  Future<Either<Failure, LoginEntity>> login(
      LoginParams params) async {
    try {
      final model = await remote.login(
        username: params.username,
        password: params.password,
      );

      // Store token & ID
      await storage.write('AUTH_TOKEN', model.token);
      await storage.write('USER_ID', model.userId);

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
