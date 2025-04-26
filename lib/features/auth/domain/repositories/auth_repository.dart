abstract class AuthRepository {
  /// Autentica al usuario (usando biometría o PIN).
  Future<bool> authenticateUser();

  /// Obtiene el estado actual de autenticación.
  Future<bool> isAuthenticated();

  /// Limpia o resetea el estado de autenticación.
  Future<void> logout();
}
