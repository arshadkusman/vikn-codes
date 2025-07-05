import 'package:dartz/dartz.dart';
import 'package:vikn_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile(NoParams params);
  Future<void> logout();
}
