import 'package:vikn_task/features/filter/domain/entities/filter_params.dart';


class ApplyFilterUseCase {
  // In a fuller implementation, you might inject a repository to re-fetch data.
  Future<FilterParams> call(FilterParams params) async {
    return params;
  }
}
