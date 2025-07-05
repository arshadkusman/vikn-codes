import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikn_task/features/sales/domain/usecase/get_sales_list_usecase.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  final GetSalesListUseCase getSales;
  int _currentPage = 1;

  SalesCubit({required this.getSales}) : super(SalesInitial());

  void fetchSales({int page = 1}) async {
    emit(SalesLoading());
    final result = await getSales(SalesParams(pageNo: page));
    result.fold(
      (f) => emit(SalesFailure(f.message)),
      (list) {
        _currentPage = page;
        emit(SalesLoaded(list));
      },
    );
  }
}
