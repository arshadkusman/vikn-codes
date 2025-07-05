import 'package:dartz/dartz.dart';
import 'package:vikn_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

class LoginUseCase implements UseCase<LoginEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) {
    return repository.login(params);
  }
}
