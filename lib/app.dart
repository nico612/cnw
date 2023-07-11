import 'package:cniao/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cniao/common/authentication/bloc/authentication_bloc.dart';
import 'package:cniao/pages/login/view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/main_layout/layout.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    super.key
    });

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    /// 为其子组件提供数据仓库。 用于管理数据的类，通常用于从远程服务器或本地数据库获取数据，
    /// 通过将数据仓库注入到应用程序的小部件树中，使得整个应用程序可以轻松地访问和使用数据仓库
    /// 将数据仓库注入到整个应用程序中，以便不同部分可以共享和访问相同的数据源。这在需要在多个页面或小部件之间共享数据时非常有用。 
    return RepositoryProvider<AuthenticationRepository>.value( 
      value: authenticationRepository,
      
      /// BlocProvider 是用于提供BLoC（Business Logic Component）的提供程序。BLoC是一种用于管理业务逻辑的设计模式，它将输入事件映射到状态输出。 
      /// BlocProvider 通过将BLoC注入到应用程序的小部件树中，使得在整个应用程序中可以轻松地访问和使用BLoC。 
      /// 将BLoC注入到单个小部件或页面中，以便管理该小部件或页面的状态和业务逻辑。这在需要对特定小部件或页面进行状态管理时非常有用。
      child: BlocProvider<AuthenticationBloc>( 
        create: (context)  {
          AuthenticationBloc bloc = AuthenticationBloc(authenticationRepository: authenticationRepository);
          bloc.add(AppStartEvent());
          return bloc;
        },
        lazy: false, //默认情况下，`BlocProvider` 通过懒加载创建的，意思是当通过`BlocProvider.of<BlocA>(context)`执行查找时`Create`方法才执行, 如果将`lazy`设置为`false`则会强制立即执行
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( //用于初始化屏幕适配
        builder: (context, child) => MaterialApp(
          home: MainLayout(),
          builder: EasyLoading.init(),
        ),
      designSize: const Size(1080, 1920), // 设计稿的尺寸
    );
  }

  Widget homeWidget() {
    return const MainLayout();
  }
}

