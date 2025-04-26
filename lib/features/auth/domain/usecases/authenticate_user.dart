import '../repositories/auth_repository.dart';

class AuthenticateUser {
  final AuthRepository repository;

  AuthenticateUser(this.repository);

  Future<bool> call() async {
    return await repository.authenticateUser();
  }
}
