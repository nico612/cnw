

import 'package:cniao/pages/index/bloc/index_bloc.dart';
import 'package:cniao/pages/index/course/view/index.dart';
import 'package:cniao/pages/index/grade/view/index.dart';
import 'package:cniao/pages/index/recommend/view/index.dart';
import 'package:cniao/widgets/tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  
  IndexPage({super.key});

  /// 定义indexBloc实例变量，用于在整个IndexPage生命周期中共享数据
  /// 定义在该Widge中确保indexBloc在整个IndexPage的生命周期内保持一致
  /// 在每次IndexPage重建时，widget.indexBloc的引用都会保持不变，从而保持了IndexBloc对象的状态。
  final IndexBloc indexBloc = IndexBloc();

  final tabViews = <Widget>[
    RecommendPage(),
    CoursePage(),
    CoursePage(),
    GradePage()
    
  ];

  @override
  State<IndexPage> createState() => _IndexPageState();
}



/// state 状态类
/// 在StatefulWidget的生命周期内，State对象可能会多次创建和销毁，
/// 但它的数据需要在这些重建中保持一致，因此需要将数据放在StatefulWidget类中。比如上面indexBloc实例
/// 然后通过widget来获取Widget中的数据
class _IndexPageState extends State<IndexPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 提供Bloc实例的依赖注入。它可以确保在小部件树中的所有子部件都可以访问到相同的Bloc实例。
    return BlocProvider( 
      create: (context) => widget.indexBloc,
      // BlocBuilder: 用于订阅Bloc的状态流，并在状态发生变化时重新构建UI
      child: BlocBuilder<IndexBloc, IndexState>(
        builder: (context, state) {
            return DefaultTabController(
              length: state.tabs.length, 
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  // 去掉导航条下面的阴影
                  elevation: 0,
                  title: const Text("search bar", style: TextStyle(color: Colors.redAccent),),
                  bottom: PreferredSize( //指定一个部件的首选大小，可以用于自定义AppBar的大小，或者其他需要指定大小的部件
                    preferredSize: const Size.fromHeight(30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        onTap: (index) {
                          context.read<IndexBloc>().add(SelectedIndexChangeEvent(index));
                        }, 
                        isScrollable: true,
                        labelColor: const Color(0xFFFC9900),
                        labelStyle: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w500),
                        unselectedLabelColor: const Color(0xFF303132),
                        indicator: TabSizeIndicator(
                          wantWidth: 50.w,
                          borderSide: const BorderSide(width: 3.0, color: Color(0xFFFC9900))
                        ),
                        tabs: state.tabs.map((value) => Text(value)).toList(),
                      ),
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TabBarView( //TabBarView中，子Widget的约束条件由父级widget，这里是Padding来提供的，TabBarView会根据这些约束来确定子Widget的最终尺寸和位置
                    children: widget.tabViews,
                    ),
                  ),
              )
              );
        },
      ),
      );
  }


  @override
  bool get wantKeepAlive => true;
}