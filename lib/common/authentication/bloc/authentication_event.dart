part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

// app start event
class AppStartEvent extends AuthenticationEvent {}

// login envet
class LoginEvent extends AuthenticationEvent {
  final String token;
  final User user;

  const LoginEvent(this.token, this.user);

  @override
  List<Object?> get props => [token, user];

  @override
  String toString() {
    return 'LoginEvent{token: $token}';
  }
}

// login out event
class LoginOutEvent extends AuthenticationEvent {}


