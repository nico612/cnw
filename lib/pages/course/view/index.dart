
import 'package:cniao/common/icons.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/common/values/font_size.dart';
import 'package:cniao/pages/course/bloc/courselist_bloc.dart';
import 'package:cniao/pages/course/models/course_request_model.dart';
import 'package:cniao/pages/course/view/course_tabbar.dart';
import 'package:cniao/pages/course/view/courselist_const.dart';
import 'package:cniao/pages/course/view/dropdownlist.dart';
import 'package:cniao/pages/course/view/filter_page/filter_page.dart';
import 'package:cniao/pages/index/course/bloc/course_bloc.dart';
import 'package:cniao/pages/index/course/view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final filterTabKey = GlobalKey<_CourseListPageState>();

class CourseListPage extends StatefulWidget {
  CourseListPage({super.key});

  final CourseListBloc courseListBloc = CourseListBloc();

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    widget.courseListBloc.add(const GetCategoriesEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      bottom: false,
      child: BlocProvider(
          create: (context) => widget.courseListBloc,
          child:  BlocBuilder<CourseListBloc, CourseListState>(
            buildWhen: (previous, current) => previous.tabs != current.tabs,
            builder: (context, state) {
              if (state.tabs == null) return Container();
              _tabController = TabController(initialIndex: 0, length: state.tabs?.length ?? 1, vsync: this);
              return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseTabBarWidget(tabController: _tabController,),
                      //这里加入key，方便弹窗时找到该widge的位置
                      const CourseFilter(),
                      CourseTabPages(
                        tabController: _tabController,
                      )
                    ],
                  );
            }
          )        
        )
    );
  }
}

// 顶部TabBar
class CourseTabBarWidget extends StatelessWidget {

  const CourseTabBarWidget({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListBloc, CourseListState>(
        builder: (context, state) {
          return TabBarWidget( // 课程分类列表
            tabController: tabController,
            tabs:state.tabs?.map((e) => Text(e.title ?? "")).toList() ?? [],
            selectChanged: (index) {
              // 发送tabBar改变事件
              context
                  .read<CourseListBloc>()
                  .add(SelectedTabIndexChangedEvent(index));
                  CourseOverlayEntryPage.dismiss();

              },


          );
        }
    );
  }
}

// 条件限制栏
class CourseFilter extends StatelessWidget {

  const CourseFilter({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CourseListBloc, CourseListState>(

      builder: (context, state) {

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: filterTabs(state, context),
            )
        );
      },
    );
  }

  List<Widget> filterTabs(CourseListState state, BuildContext context) {


        return state.filterSelectedIndexs //选中状态的titles
                  .asMap()
                  .map((itemIndex, filterItem) {
                List<Map<String, dynamic>> cTabList =
                CourseListFilters[itemIndex];

                Map<String, dynamic> cSelectedItem =
                cTabList[filterItem.selectedIndex]; //选中的title

                return MapEntry(
                    itemIndex, FilterTab(title: cSelectedItem['title'] as String, isSelected: filterItem.isSelected, onTap: () {
                        context.read<CourseListBloc>().add(FilterItemSelectedEvent(itemIndex));
                          List<String> menus = cTabList.map((e) => e['title'] as String).toList();
                        _showDropDownList(context, menus, filterItem, itemIndex);
                    },));
              }).values.toList();
    }

  void _dismissDropDownList() {
      CourseOverlayEntryPage.dismiss();
  } 

  /// menus: 展示菜单列表
  /// itemIndex： 限制按钮index
  /// 菜单列表选择 index
  void _showDropDownList(BuildContext context, List<String> menus, FliterItemState filterItem, int itemIndex) {
      _dismissDropDownList();

      if (filterItem.isSelected) return ;
        //1. 如果点击的同一个index，直接show或者dimiss

        // 1. 如果已有打开的先dismiss，然后再打开新的

    final box = context.findRenderObject() as RenderBox;
    final dy = box.localToGlobal(Offset(0, box.size.height)).dy;

    CourseOverlayEntryPage.showPages(
        top: dy,
        context: context,
        container: CourseOverlayContainerPage(
            menus: menus,
            selectedIndex: filterItem.selectedIndex,
            selectCallback: ((index) {
                CourseOverlayEntryPage.dismiss();
              // if (index == filterItem.selectedIndex) return ;
              // 触发事件值改变事件
              context
                  .read<CourseListBloc>()
                  .add(FilterSelectedIndexChangedEvent(itemIndex, index));
            })),

    );

  }
}

// 遮
class CourseOverlayContainerPage extends StatelessWidget {
  const CourseOverlayContainerPage({super.key,
    required this.menus,
    required this.selectedIndex,
    this.selectCallback});

  final List<String> menus;
  final int selectedIndex;
  final DropDownListCallback? selectCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(height: menus.length * 51.0),
      child: DropDownList(
        menus: menus,
        selectedIndex: selectedIndex,
        onTap: selectCallback,
      ),
    );
  }
}

typedef OnTapEntryBackground = void Function();

class CourseOverlayEntryPage extends OverlayEntry {
  static bool isDrop = false;

  CourseOverlayEntryPage({required super.builder});

  factory CourseOverlayEntryPage.fromPosition({
        double? left = 0,
        double? top = 0,
        double? right = 0,
        double? bottom = 0,
        Color? color = const Color(0x55000000),
        Widget? container,
        OnTapEntryBackground? tapEntryBackground}) {
    return CourseOverlayEntryPage(
        builder: (context) =>
            Positioned.fill(
              left: left,
              top: top,
              right: right,
              bottom: bottom,
              child: GestureDetector(
                onTap: tapEntryBackground,
                child: Material(
                  color: color,
                  child: Stack(
                    children: [
                      // Container(
                      //   color: Colors.redAccent,
                      // ),
                      container ?? Container()
                    ],
                  ),
                ),
              ),
            )
    );
  }

  static CourseOverlayEntryPage? _overlayEntryPage;


  static showPages({
    // bool show = true,
    required BuildContext context,
    Widget? container,
    double? left = 0,
    double? top = 0,
    double? right = 0,
    double? bottom = 0,
    }) {

    _overlayEntryPage = CourseOverlayEntryPage.fromPosition(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        container: container,
        tapEntryBackground: () => dismiss());

    OverlayState? state = Overlay.maybeOf(context);
    print("state = $state");

    Overlay.maybeOf(context)?.insert(_overlayEntryPage!);
  }

  static void dismiss() {
    if(_overlayEntryPage?.mounted ?? false) {
      _overlayEntryPage?.remove();
    }
  }
}



class CourseTabPages extends StatelessWidget {
  const CourseTabPages({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListBloc, CourseListState>(
        builder: ((context, state) {

            final courseType = CourseListFilters[0][state.filterSelectedIndexs[0].selectedIndex]['value'] as int;
            final diff = CourseListFilters[1][state.filterSelectedIndexs[1].selectedIndex]['value'] as int;
            final free = CourseListFilters[2][state.filterSelectedIndexs[2].selectedIndex]['value'] as int;
            final sortField = CourseListFilters[3][state.filterSelectedIndexs[3].selectedIndex]['value'] as int;
            String sortStr;

            switch (sortField) {
              case 1:
              sortStr = "comment";
              break;
              case 2:
              sortStr = "study";
              default:
              sortStr = "timne";
              break;
            }

          return Expanded(
              child: TabBarView(
                controller: tabController,
                children: state.tabs?.asMap().map((index, tab) {
                      
                      return MapEntry(index, CoursePage(courseBloc: CourseBloc(),requestModel: CourseRequestModel(
                          courseType: courseType,
                          difficulty: diff,
                          free: free,
                          sortField: sortStr
                        )
                      )
                    );
                    
                    }).values
                    .toList() ??
                    [],
              ));
        }));
  }
}
