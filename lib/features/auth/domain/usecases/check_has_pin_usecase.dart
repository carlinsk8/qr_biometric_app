
import 'package:qr_biometric_app/core/services/secure_storage_service.dart';

class CheckHasPinUseCase {
  final SecureStorageService secureStorageService;

  CheckHasPinUseCase(this.secureStorageService);

  Future<bool> call() async {
    return secureStorageService.hasPin();
  }
}
