import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticateRequested extends AuthEvent {}

class CheckAuthenticationStatus extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
