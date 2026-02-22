import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loynova_assessment/core/constants.dart';
import 'package:loynova_assessment/core/network/api.dart';
import 'package:loynova_assessment/features/transfer_points/data/repositories/transfer_repository_imp.dart';
import 'package:loynova_assessment/features/wallet/data/repositories/wallet_repository_imp.dart';

import '../../features/transfer_points/domain/repositories/transfer_repository.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.shopplus.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  });

  // DioWrapper
  getIt.registerLazySingleton<DioWrapper>(() => DioWrapper(getIt<Dio>()));

  // ApiClient
  getIt.registerLazySingleton<ApiClient>(
    () => DioApiClient(getIt<DioWrapper>()),
  );

  // Repositories
  getIt.registerLazySingleton<WalletRepository>(
    () => MockWalletRepository(Constants.mockTransactions),
  );

  getIt.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImp(),
  );
}
