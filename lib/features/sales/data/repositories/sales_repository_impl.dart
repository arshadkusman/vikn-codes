// features/sales/data/repositories/sales_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:vikn_task/features/sales/data/datasource/sales_remote_datasource.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/sale_item.dart';
import '../../domain/repositories/sales_repository.dart';
import '../../domain/usecase/get_sales_list_usecase.dart';

class SalesRepositoryImpl implements SalesRepository {
  final SalesRemoteDataSource remote;
  final SecureStorage storage;

  SalesRepositoryImpl({required this.remote, required this.storage});

  @override
  Future<Either<Failure, List<SaleItem>>> getSalesList(
    SalesParams params,
  ) async {
    try {
      final userId = await storage.read('USER_ID') ?? '';
      final resp = await remote.fetchSales(
        userId: userId,
        pageNo: params.pageNo,
      );
      return Right(resp.items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
