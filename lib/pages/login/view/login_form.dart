import 'package:cniao/common/icons.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/pages/login/bloc/login_bloc.dart';
import 'package:cniao/theme/style.dart';
import 'package:cniao/widgets/field.dart';
import 'package:cniao/widgets/n_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {

  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    return  BlocListener<LoginBloc, LoginState>(
      listener: (context, state) { //监听登录状态
        if(state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("登录失败， 请检查账号密码是否正确")));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, //设置主轴尺寸为尽可能小，默认为max以填充可用空间
        children: [
          _UserNameInput(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          _PasswordInput(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: _PrivacyText()
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _LoginButton(),
          ),
        ],
      ),
    );
  }
}

class _UserNameInput extends StatelessWidget {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.mobileValidation != current.mobileValidation,
      builder: (context, state) {
        return Field(
          controller: _controller,
          autofocus: false,
          placeholder: "手机号",
          labelWidth: 50,
          maxLength: 11,
          leftIcon: CNWFonts.mobile,
          keyboardType: TextInputType.phone,
          error:  state.mobileValidation.displayError != null , //验证是否错误，初始化值不算
          errorMessage: state.mobileValidation.displayError, //错误提示
          onChange: (mobile) {
            context.read<LoginBloc>().add(MobileChangeEvent(mobile));
            //发送事件
          },
        );
      }
    );
  }
}
//
class _PasswordInput extends StatelessWidget {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (pre, current) => pre.passwordInputValidation != current.passwordInputValidation,
        builder: (context, state) {
            return Field(
              controller: _controller,
              placeholder: "密码",
              type: "password",
              labelWidth: 50,
              leftIcon: CNWFonts.security,
              keyboardType: TextInputType.text,
              error: state.passwordInputValidation.displayError != null,
              errorMessage: state.passwordInputValidation.displayError,
              onChange: (password) {
                context.read<LoginBloc>().add(PasswordChangeEvent(password));
              },
            );
        }
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previos, current) {
          return previos != current;
        },
        builder: (context, state) {
          return NButton(
            loading: state.status.isInProgress,
            disabled: state.status.isInProgressOrSuccess || state.isNotValid || state.isPure,
            block: true,
            color: AppColors.primaryColor,
            text: "登 录",
            borderRadius: BorderRadius.circular(100.w),
            onClick: () {
              FocusScope.of(context).unfocus();
              if (!state.status.isSuccess) {
                context.read<LoginBloc>().add(const OnLoginEvent());
              }
            },
          );
        }
    );
  }

}

class _PrivacyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TextSpan normalText(String text) {
      return TextSpan(
          text: text,
          style: const TextStyle(color: Style.textColor),
      );
    }
    TextSpan selectText(String text, {void Function()? onTap}) {
      return TextSpan(
          text: text,
          style: const TextStyle(color: Style.blue),
          recognizer: TapGestureRecognizer()..onTap = onTap
      );
    }

    return RichText(
        text: TextSpan(
          children: [
            normalText("登录表示同意"),
            selectText("《服务协议》", onTap: () {
              print("点击服务协议");
            }),
            normalText("、"),
            selectText("《隐私政策》", onTap: () {
              print("点击隐私政策");
            }),
          ]
        )
    );
  }

}