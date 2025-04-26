import '../entities/qr_code.dart';
import '../repositories/qr_repository.dart';

class GetAllQrCodesUseCase {
  final QrRepository repository;

  GetAllQrCodesUseCase(this.repository);

  Future<List<QrCode>> call() async {
    return await repository.getAllQrCodes();
  }
}
