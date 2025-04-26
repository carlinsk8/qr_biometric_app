import '../repositories/qr_repository.dart';

class SaveQrCodeUseCase {
  final QrRepository repository;

  SaveQrCodeUseCase(this.repository);

  Future<void> call(String code) async {
    await repository.saveQrCode(code);
  }
}
