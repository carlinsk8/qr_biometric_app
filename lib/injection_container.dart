import 'package:get_it/get_it.dart';

import 'core/platform_channels/biometric_auth_api.dart';
import 'core/services/secure_storage_service.dart';

import 'features/auth/data/datasources/auth_local_datasources.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/authenticate_user.dart';
import 'features/auth/domain/usecases/check_has_pin_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/qr_scan/data/datasources/qr_local_datasource.dart';
import 'features/qr_scan/data/repositories/qr_repository_impl.dart';
import 'features/qr_scan/domain/repositories/qr_repository.dart';
import 'features/qr_scan/domain/usecases/get_all_qr_codes.dart';
import 'features/qr_scan/domain/usecases/save_qr_code.dart';
import 'features/qr_scan/presentation/bloc/qr_bloc.dart';

final sl = GetIt.instance; // sl = service locator

Future<void> init() async {
  //! Core
  _initCore();

  //! Features - Auth
  _initAuthFeature();

  //! Features - QR Scan
  _initQrScanFeature();
}

void _initCore() {
  // Services
  sl.registerLazySingleton(() => SecureStorageService.instance);

  // Platform Channels
  sl.registerLazySingleton<BiometricAuthApi>(() => BiometricAuthApi());
}

void _initAuthFeature() {
  // Bloc
  sl.registerFactory(() => AuthBloc(authenticateUser: sl()));

  // UseCases
  sl.registerLazySingleton(() => AuthenticateUser(sl()));
  sl.registerLazySingleton(() => CheckHasPinUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDatasource: sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => AuthLocalDatasource());
}

void _initQrScanFeature() {
  // Bloc
  sl.registerFactory(() => QrBloc(
    saveQrCodeUseCase: sl(),
    getAllQrCodes: sl(),
  ));

  // UseCases
  sl.registerLazySingleton(() => SaveQrCodeUseCase(sl()));
  sl.registerLazySingleton(() => GetAllQrCodesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<QrRepository>(
    () => QrRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => QrLocalDatasource());
}
