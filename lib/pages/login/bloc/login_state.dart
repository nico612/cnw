part of 'login_bloc.dart';


// 实现 FormzMixin 的验证状态，由LoginState整个表单的验证状态
class LoginState extends Equatable with FormzMixin {

  final FormzSubmissionStatus status;     //表单提交状态如：提交中、成功、失败
  final MobileValidation mobileValidation;  // 手机号验证状态
  final PasswordInputValidation passwordInputValidation; //密码验证状态

   const LoginState({
     this.status = FormzSubmissionStatus.initial,
     this.mobileValidation = const MobileValidation.pure(),
     this.passwordInputValidation = const PasswordInputValidation.pure()
   });

   LoginState copyWith({FormzSubmissionStatus? status, MobileValidation? mobileValidation, PasswordInputValidation? passwordInputValidation}) {
      return LoginState(
          status: status ?? this.status,
          mobileValidation: mobileValidation ?? this.mobileValidation,
          passwordInputValidation: passwordInputValidation ?? this.passwordInputValidation
      );
   }

  @override
  List<Object?> get props => [status, mobileValidation, passwordInputValidation];

   // 复写FormzMixin 的inputs，提供所有需要验证的表单
  @override
  List<FormzInput> get inputs => [mobileValidation, passwordInputValidation];

}
