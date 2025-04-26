import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/authenticate_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateUser authenticateUser;

  AuthBloc({required this.authenticateUser}) : super(AuthInitial()) {
    on<AuthenticateRequested>(_onAuthenticateRequested);
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthenticateRequested(
    AuthenticateRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authenticateUser();
      if (result) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Error durante la autenticación'));
    }
  }

  Future<void> _onCheckAuthenticationStatus(
    CheckAuthenticationStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isAuth = await authenticateUser.repository.isAuthenticated();
      if (isAuth) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError('Error al verificar el estado de autenticación'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authenticateUser.repository.logout();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Error durante el cierre de sesión'));
    }
  }
}
