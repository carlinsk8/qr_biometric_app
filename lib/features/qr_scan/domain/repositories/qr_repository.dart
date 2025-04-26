import '../entities/qr_code.dart';

abstract class QrRepository {
  Future<void> saveQrCode(String code);
  Future<List<QrCode>> getAllQrCodes();
}
