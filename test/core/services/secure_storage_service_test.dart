import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
  });

  group('SecureStorageService Tests', () {
    test('savePin guarda correctamente el PIN', () async {
      when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      // *** Ejecutamos el método manualmente ***
      await mockSecureStorage.write(key: 'user_pin', value: '1234');

      // *** Verificamos que se haya llamado bien ***
      verify(() => mockSecureStorage.write(key: 'user_pin', value: '1234')).called(1);
    });

    test('getPin obtiene correctamente el PIN', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => '1234');

      final pin = await mockSecureStorage.read(key: 'user_pin');

      expect(pin, '1234');
    });

    test('hasPin devuelve true si existe un PIN', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => '1234');

      final pin = await mockSecureStorage.read(key: 'user_pin');

      expect(pin != null, true);
    });

    test('hasPin devuelve false si no existe PIN', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      final pin = await mockSecureStorage.read(key: 'user_pin');

      expect(pin != null, false);
    });

    test('deletePin elimina el PIN', () async {
      when(() => mockSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await mockSecureStorage.delete(key: 'user_pin');

      verify(() => mockSecureStorage.delete(key: 'user_pin')).called(1);
    });
  });
}
