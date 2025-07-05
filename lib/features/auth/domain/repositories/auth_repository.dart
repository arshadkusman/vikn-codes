import 'package:dartz/dartz.dart';
import 'package:vikn_task/features/auth/domain/usecase/login_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}
