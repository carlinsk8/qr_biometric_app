import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final instance = SecureStorageService._internal();

  final FlutterSecureStorage _storage;

  // Constructor normal
  SecureStorageService._internal() : _storage = const FlutterSecureStorage();
  
  // Constructor utilizado para propósitos de prueba
  // ignore: unused_element
  SecureStorageService._internalForTest(this._storage);

  static const _pinKey = 'user_pin';

  Future<bool> hasPin() async {
    final pin = await _storage.read(key: _pinKey);
    return pin != null;
  }

  Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  Future<void> deletePin() async {
    await _storage.delete(key: _pinKey);
  }
}
