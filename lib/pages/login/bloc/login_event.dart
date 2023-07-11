part of 'login_bloc.dart';

@immutable
abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent();

  @override
  List<Object?> get props => [];
}

class MobileChangeEvent extends UserLoginEvent {
  const MobileChangeEvent(this.mobile);
  final String mobile;
  @override
  // TODO: implement props
  List<Object?> get props => [mobile];
}

class PasswordChangeEvent extends UserLoginEvent {
  final String password;

  const PasswordChangeEvent(this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [password];
}

class OnLoginEvent extends UserLoginEvent {
  const OnLoginEvent();
}