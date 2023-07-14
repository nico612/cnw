import 'package:cniao/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cniao/common/authentication/bloc/authentication_bloc.dart';
import 'package:cniao/common/icons.dart';
import 'package:cniao/pages/login/bloc/login_bloc.dart';
import 'package:cniao/pages/login/view/login_form.dart';
import 'package:cniao/theme/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {

  static Route route () {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CNWFonts.back,
            color: Color(0xFF303133),
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "用户登录",
          style: TextStyle(color: Color(0xff333333)),
        ),
        backgroundColor: Colors.white,
        elevation: 0, //appBar 阴影
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: ClipOval(
                    child: Container(
                      color: const Color(0xFFf5f5f5),
                      width: 200.w,
                      height: 200.w,
                      child: Image(
                        image: const AssetImage("assets/login/logo1.png"),
                        width: 100.w,
                        fit: BoxFit.fill,
                        ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  //设置内边距
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: BlocProvider(
                    create: (context) {
                      //注入LoginBloc
                      return LoginBloc(
                        //从当前的  BuildContext  中获取已经创建的  AuthenticationBloc  实例。
                        // 这里的AuthenticationBloc 是在APP类中通过BlocProvider提供的，全局皆可5访问
                        authenticationBloc: context.read<AuthenticationBloc>()
                      );
                    },
                      child: const LoginForm())
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                    text: TextSpan(
                        text: "账号密码登录",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          print("账号密码登录");
                        }
                    )
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 30, left: 14, right: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Style.gray2,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '社交账号登录',
                          style: TextStyle(fontSize: 16, color: Style.gray6),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Style.gray2,
                        ),
                      ),

                    ],
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: GestureDetector(
                        child: const Image(
                          image: AssetImage("assets/login/logo1.png"),
                        ),
                        onTap: () {
                          print("点击图片");
                        },
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




