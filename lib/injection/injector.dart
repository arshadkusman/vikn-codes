import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:vikn_task/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vikn_task/features/auth/domain/usecase/login_usecase.dart';
import 'package:vikn_task/features/profile/data/data_souces/profile_remote_datasource.dart';
import 'package:vikn_task/features/sales/data/datasource/sales_remote_datasource.dart';
import 'package:vikn_task/features/sales/domain/usecase/get_sales_list_usecase.dart';

import '../core/network/api_client.dart';
import '../core/storage/secure_storage.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/presentation/bloc/auth_cubit.dart';
import '../features/sales/data/repositories/sales_repository_impl.dart';
import '../features/sales/presentation/bloc/sales_cubit.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/usecases/get_profile_usecase.dart';
import '../features/profile/domain/usecases/logout_usecase.dart';
import '../features/profile/presentation/bloc/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => SecureStorage());
  sl.registerLazySingleton(() => ApiClient(sl<Dio>(), sl<SecureStorage>()));

  // Auth feature
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton(
    () => LoginUseCase(
      AuthRepositoryImpl(
        remote: sl<AuthRemoteDataSource>(),
        storage: sl<SecureStorage>(),
      ),
    ),
  );
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      storage: sl<SecureStorage>(),
    ),
  );

  // Sales feature
  sl.registerLazySingleton<SalesRemoteDataSource>(
    () => SalesRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton(
    () => GetSalesListUseCase(
      SalesRepositoryImpl(
        remote: sl<SalesRemoteDataSource>(),
        storage: sl<SecureStorage>(),
      ),
    ),
  );
  sl.registerFactory(() => SalesCubit(getSales: sl<GetSalesListUseCase>()));

  // Profile feature
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton(
    () => GetProfileUseCase(
      ProfileRepositoryImpl(
        remote: sl<ProfileRemoteDataSource>(),
        storage: sl<SecureStorage>(),
      ),
    ),
  );
  sl.registerLazySingleton(
    () => LogoutUseCase(
      ProfileRepositoryImpl(
        remote: sl<ProfileRemoteDataSource>(),
        storage: sl<SecureStorage>(),
      ),
    ),
  );
  sl.registerFactory(
    () => ProfileCubit(
      getProfile: sl<GetProfileUseCase>(),
      logoutUc: sl<LogoutUseCase>(),
    ),
  );

  // (If you add Filter usecases or others, register them here)
  sl.registerLazySingleton<ApiClient>(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://www.api.viknbooks.com/api/v10';
    return ApiClient(dio, sl<SecureStorage>());
  }, instanceName: 'booksApi');
}
