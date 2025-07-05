import 'package:vikn_task/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:vikn_task/core/error/failures.dart';

import '../repositories/profile_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final ProfileRepository repository;
  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      await repository.logout();
      return Right(null);
    } catch (e) {
      // You may want to map the error to a Failure type more specifically
      return Left(ServerFailure(e.toString()));
    }
  }
}
