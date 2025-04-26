class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

class QrScannerException implements Exception {
  final String message;
  QrScannerException(this.message);

  @override
  String toString() => 'QrScannerException: $message';
}