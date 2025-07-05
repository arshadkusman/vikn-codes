import 'package:dartz/dartz.dart';
import 'package:vikn_task/core/usecase/usecase.dart';
import 'package:vikn_task/features/profile/data/data_souces/profile_remote_datasource.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;
  final SecureStorage storage;

  ProfileRepositoryImpl({
    required this.remote,
    required this.storage,
  });

  @override
  Future<Either<Failure, Profile>> getProfile(NoParams params) async {
    try {
      final uid = await storage.read('USER_ID') ?? '';
      final model = await remote.fetchProfile(uid);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await storage.clearAll();
  }
}
