import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class QrScannerApi {
  /// Abre la cámara y escanea un QR, retornando el contenido escaneado.
  @async
  String scanQrCode();
}
