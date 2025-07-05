import 'package:dartz/dartz.dart';
import 'package:vikn_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/sale_item.dart';
import '../repositories/sales_repository.dart';

class SalesParams {
  final int pageNo;
  SalesParams({required this.pageNo});
}

class GetSalesListUseCase
    implements UseCase<List<SaleItem>, SalesParams> {
  final SalesRepository repository;
  GetSalesListUseCase(this.repository);

  @override
  Future<Either<Failure, List<SaleItem>>> call(
      SalesParams params) {
    return repository.getSalesList(params);
  }
}
