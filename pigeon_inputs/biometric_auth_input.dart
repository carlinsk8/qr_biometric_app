import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class BiometricAuthApi {
  @async
  bool authenticate();
}
