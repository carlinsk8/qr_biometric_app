import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/entities/qr_code.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/usecases/get_all_qr_codes.dart';
import 'package:qr_biometric_app/features/qr_scan/domain/usecases/save_qr_code.dart';
import 'package:qr_biometric_app/features/qr_scan/presentation/bloc/qr_bloc.dart';

class MockSaveQrCodeUseCase extends Mock implements SaveQrCodeUseCase {}

class MockGetAllQrCodesUseCase extends Mock implements GetAllQrCodesUseCase {}

void main() {
  late QrBloc qrBloc;
  late MockSaveQrCodeUseCase mockSaveQrCodeUseCase;
  late MockGetAllQrCodesUseCase mockGetAllQrCodesUseCase;

  setUp(() {
    mockSaveQrCodeUseCase = MockSaveQrCodeUseCase();
    mockGetAllQrCodesUseCase = MockGetAllQrCodesUseCase();
    qrBloc = QrBloc(
      saveQrCodeUseCase: mockSaveQrCodeUseCase,
      getAllQrCodes: mockGetAllQrCodesUseCase,
    );
  });

  tearDown(() {
    qrBloc.close();
  });
  final mockQrCode = QrCode(
    id: 1,
    code: 'QR123',
    timestamp: DateTime.now().toIso8601String(),
  );

  blocTest<QrBloc, QrState>(
    'emite [QrLoading, QrListLoaded] cuando SaveQrCodeEvent es exitoso',
    build: () {
      when(
        () => mockSaveQrCodeUseCase.call(any()),
      ).thenAnswer((_) async => Future<void>.value());
      when(
        () => mockGetAllQrCodesUseCase.call(),
      ).thenAnswer((_) async => [mockQrCode]);
      return qrBloc;
    },
    act: (bloc) => bloc.add(SaveQrCodeEvent('QR123')),
    expect:
        () => [
          QrLoading(),
          QrListLoaded([mockQrCode]), // 👈🏼 ahora pasa un objeto QrCode real
        ],
  );

  blocTest<QrBloc, QrState>(
    'emite [QrLoading, QrListLoaded] cuando LoadQrCodesEvent es exitoso',
    build: () {
      when(
        () => mockGetAllQrCodesUseCase.call(),
      ).thenAnswer((_) async => [mockQrCode]);
      return qrBloc;
    },
    act: (bloc) => bloc.add(LoadQrCodesEvent()),
    expect:
        () => [
          QrLoading(),
          QrListLoaded([mockQrCode]),
        ],
  );
}
