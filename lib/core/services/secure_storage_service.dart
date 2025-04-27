import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final instance = SecureStorageService._internal();

  final FlutterSecureStorage _storage;

  // Constructor normal
  SecureStorageService._internal() : _storage = const FlutterSecureStorage();

  // Constructor utilizado para propósitos de prueba
  // ignore: unused_element
  SecureStorageService._internalForTest(this._storage);

  static const _authTokenKey = 'auth_token';

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _authTokenKey);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: _authTokenKey);
  }

  Future<bool> hasAuthToken() async {
    final token = await _storage.read(key: _authTokenKey);
    return token != null;
  }
}
