import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDatasource {
  static const _storage = FlutterSecureStorage();
  static const _authKey = 'is_authenticated';

  /// Guarda el estado de autenticación
  Future<void> saveAuthenticationStatus(bool isAuthenticated) async {
    await _storage.write(key: _authKey, value: isAuthenticated.toString());
  }

  /// Obtiene el estado de autenticación
  Future<bool> getAuthenticationStatus() async {
    final value = await _storage.read(key: _authKey);
    return value == 'true';
  }

  /// Borra el estado de autenticación
  Future<void> clearAuthenticationStatus() async {
    await _storage.delete(key: _authKey);
  }
}
