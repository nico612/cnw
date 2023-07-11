import 'dart:async';

import 'package:cniao/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cniao/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  late AuthenticationRepository authenticationRepository;

  AuthenticationBloc({
    required this.authenticationRepository
  }) : super(const AuthenticationState.uninitialized()) {

    // 启动时初始化用户数据
    on<AppStartEvent>(_onAppStart);

    on<LoginEvent>(_onLogin);

    on<LoginOutEvent>(_onLogout);

  }

  // 事件处理
  FutureOr<void>_onAppStart(AppStartEvent event, Emitter<AuthenticationState> emitter) {
    User? user = authenticationRepository.getUser();
    user == null ? emitter(const AuthenticationState.unauthenticated()) : emitter(AuthenticationState.authenticated(user));
  }

  FutureOr<void>_onLogin(LoginEvent event, Emitter<AuthenticationState> emitter) {
      authenticationRepository.saveAuthenticationInfo(event.user, event.token);
      emitter(AuthenticationState.authenticated(event.user));
  }

  FutureOr<void>_onLogout(LoginOutEvent event, Emitter<AuthenticationState> emitter) {
    authenticationRepository.clearAuthenticationInfo();
    emitter(const AuthenticationState.unauthenticated());
  }


}
