import '../../../../core/errors/exceptions.dart';
import '../../../../core/platform_channels/biometric_auth_api.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({required this.localDatasource});

  @override
  Future<bool> authenticateUser() async {
    try {
      final biometricApi = BiometricAuthApi();
      final isAuthenticated = await biometricApi.authenticate(); // ← Llamada real

      if (isAuthenticated) {
        await localDatasource.saveAuthenticationStatus(true);
      }

      return isAuthenticated;
    } catch (e) {
      throw AuthException('Error durante la autenticación');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await localDatasource.getAuthenticationStatus();
    } catch (e) {
      throw AuthException('Error al obtener el estado de autenticación');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDatasource.clearAuthenticationStatus();
    } catch (e) {
      throw AuthException('Error durante el cierre de sesión');
    }
  }
}
