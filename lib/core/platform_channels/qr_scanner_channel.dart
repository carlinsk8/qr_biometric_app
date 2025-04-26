import 'qr_scanner_api.dart'; 

class QrScannerChannel {
  static final _api = QrScannerApi();

  static Future<String?> scanQrCode() async {
    try {
      final qrCode = await _api.scanQrCode();
      return qrCode;
    } catch (e) {
      return null;
    }
  }
}
