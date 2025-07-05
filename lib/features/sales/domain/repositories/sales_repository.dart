import 'package:dartz/dartz.dart';
import 'package:vikn_task/features/sales/domain/usecase/get_sales_list_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/sale_item.dart';

abstract class SalesRepository {
  Future<Either<Failure, List<SaleItem>>> getSalesList(SalesParams params);
}
