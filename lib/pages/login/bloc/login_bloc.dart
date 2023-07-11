import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cniao/common/authentication/bloc/authentication_bloc.dart';
import 'package:cniao/config.dart';
import 'package:cniao/models/user.dart';
import 'package:cniao/network/api/login/net_login.dart';
import 'package:cniao/pages/login/models/mobile_input_validation.dart';
import 'package:cniao/pages/login/models/password_input_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<UserLoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({
    required AuthenticationBloc authenticationBloc
  }) : _authenticationBloc = authenticationBloc,
        super(const LoginState()) {

    on<OnLoginEvent>(_login);

    on<MobileChangeEvent>((event, emitter) {
        // 验证输入状态
        final mobileValidation = MobileValidation.dirty(event.mobile);
        // 验证表单状态
        emitter(state.copyWith(
            mobileValidation: mobileValidation,
        ));
    });

    on<PasswordChangeEvent>((event, emitter) {
      final passwordValidation = PasswordInputValidation.dirty(event.password);
      emitter(state.copyWith(
          passwordInputValidation: passwordValidation
      ));
    });
  }


  // 处理登录事件
  FutureOr<void> _login(UserLoginEvent event, Emitter<LoginState> emitter) async {
      if (state.status.isSuccess) {
        emitter(state.copyWith());
        return;
      }

      emitter(state.copyWith(status: FormzSubmissionStatus.inProgress));
      // 网络请求
       await LoginNetManager.passwordLogin(
           mobi: state.mobileValidation.value,
           password: state.passwordInputValidation.value
       ).then((value) {
         LoginInfo loginInfo = LoginInfo.fromJson(value);
           _authenticationBloc.add(LoginEvent(loginInfo.tokenInfo.tokenValue, loginInfo.user));
           emitter(state.copyWith(status: FormzSubmissionStatus.success));
       }).catchError((err) {
         emitter(state.copyWith(status: FormzSubmissionStatus.failure));
       });
  }
}
