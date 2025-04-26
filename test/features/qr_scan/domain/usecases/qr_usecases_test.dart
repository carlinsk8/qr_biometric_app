import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/entities/qr_code.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/repositories/qr_repository.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/usecases/save_qr_code.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/usecases/get_all_qr_codes.dart';

class MockQrRepository extends Mock implements QrRepository {}

void main() {
  late MockQrRepository mockQrRepository;
  late SaveQrCodeUseCase saveQrCodeUseCase;
  late GetAllQrCodesUseCase getAllQrCodesUseCase;

  setUp(() {
    mockQrRepository = MockQrRepository();
    saveQrCodeUseCase = SaveQrCodeUseCase(mockQrRepository);
    getAllQrCodesUseCase = GetAllQrCodesUseCase(mockQrRepository);
  });

  group('SaveQrCodeUseCase', () {
    test('debería guardar el código QR llamando al repository', () async {
      // Arrange
      const testCode = 'QR123';
      when(() => mockQrRepository.saveQrCode(testCode))
          .thenAnswer((_) async => Future.value());

      // Act
      await saveQrCodeUseCase(testCode);

      // Assert
      verify(() => mockQrRepository.saveQrCode(testCode)).called(1);
    });
  });

  group('GetAllQrCodesUseCase', () {
    test('debería obtener la lista de códigos QR del repository', () async {
      // Arrange
      final qrCodes = [
        QrCode(id: 1, code: 'QR1', timestamp: DateTime.now().toIso8601String())
      ];
      when(() => mockQrRepository.getAllQrCodes())
          .thenAnswer((_) async => qrCodes);

      // Act
      final result = await getAllQrCodesUseCase();

      // Assert
      expect(result, qrCodes);
      verify(() => mockQrRepository.getAllQrCodes()).called(1);
    });
  });
}
