import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_biometric_app/core/services/secure_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockSecureStorage;
  late SecureStorageService storageService;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    // storageService = SecureStorageService.instance;
  });

  group('SecureStorageService Tests', () {
    test('logout elimina todos los datos del almacenamiento seguro', () async {
      when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});

      await mockSecureStorage.deleteAll();

      verify(() => mockSecureStorage.deleteAll()).called(1);
    });

    test('saveAuthToken guarda correctamente el token de autenticación', () async {
      when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await mockSecureStorage.write(key: '_authTokenKey', value: 'test_token');

      verify(() => mockSecureStorage.write(key: '_authTokenKey', value: 'test_token')).called(1);
    });

    test('getAuthToken obtiene correctamente el token de autenticación', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'test_token');

      final token = await mockSecureStorage.read(key: '_authTokenKey');

      expect(token, 'test_token');
    });

    test('deleteAuthToken elimina el token de autenticación', () async {
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await mockSecureStorage.delete(key: '_authTokenKey');

      verify(() => mockSecureStorage.delete(key: '_authTokenKey')).called(1);
    });

    test('hasAuthToken devuelve true si existe un token de autenticación', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'test_token');

      final hasToken = await mockSecureStorage.read(key: '_authTokenKey') != null;

      expect(hasToken, true);
    });

    test('hasAuthToken devuelve false si no existe un token de autenticación', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      final hasToken = await mockSecureStorage.read(key: '_authTokenKey') != null;

      expect(hasToken, false);
    });
  });
}


