
import 'package:cniao/common/icons.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/common/values/font_size.dart';
import 'package:cniao/pages/course/bloc/courselist_bloc.dart';
import 'package:cniao/pages/course/view/courselist_const.dart';
import 'package:cniao/pages/course/view/dropdownlist.dart';
import 'package:cniao/pages/index/course/bloc/course_bloc.dart';
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
          child: BlocBuilder<CourseListBloc, CourseListState>(
            buildWhen: (previous, current) => previous.tabs != current.tabs,
            builder: (context, state) {
              if (state.tabs == null) return Container();
              _tabController =
                  TabController(length: state.tabs?.length ?? 0, vsync: this);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CourseListBloc, CourseListState>(
                    builder: (context, state) {
                      return TabBarWidget( // 课程分类列表
                        tabController: _tabController,
                        tabs:
                            state.tabs?.map((e) => Text(e.title ?? "")).toList() ??
                                [],
                        selectChanged: (index) {

                          context
                              .read<CourseListBloc>()
                              .add(SelectedTabIndexChangedEvent(index));
                        },
                      );
                    }
                  ),
                  //这里加入key，方便弹窗时找到该widge的位置
                  CourseFilter( // 过滤条件
                    filterItemSelect: (itemIdex) => filterItemSelect( //按钮选择回调
                        itemIdex,
                        CourseListFilters[itemIdex],
                        state.filterSelectedIndexs[itemIdex]),

                    titles: state.filterSelectedIndexs //过滤条件显示列表
                        .asMap()
                        .map((itemIndex, menuSelectedIndex) {
                          List<Map<String, dynamic>> cTabList =
                              CourseListFilters[itemIndex];
                          Map<String, dynamic> cSelectedItem =
                              cTabList[menuSelectedIndex];
                          return MapEntry(
                              itemIndex, cSelectedItem['title'] as String);
                        })
                        .values
                        .toList(),
                  ),
                  BlocBuilder<CourseListBloc, CourseListState>(
                    builder: (context, state) {
                      return CourseTabPages(
                        tabController: _tabController,
                      );
                    }
                  )
                ],
              );
            },
          )),
    );
  }

  //过滤按钮点击
  // itemIndex: 过滤按钮index
  // menus 某个限制条件下的条件列表
  // selectedMenusIndex: 某个限制条件下已选择的index
  void filterItemSelect(
      int itemIndex, List<Map<String, dynamic>> menus, int selectedMenusIndex) {



    BuildContext? context = filterTabKey.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;

    final dy = box.localToGlobal(Offset(0, box.size.height)).dy;

    // 获取限制条件list
    // List<Map<String, dynamic>> menusForItem = CourseListFilters[itemIndex];
    // List<String> menus = menusForItem.map((e) => e['title'] as String).toList();

    //显示弹窗
    CourseOverlayEntryPage.showPages(
        context: context,
        rect: Rect.fromLTRB(0, dy, 0, 0),
        container: CourseOverlayContainerPage(
            menus: menus.map((e) => e['title'] as String).toList(),
            selectedIndex: selectedMenusIndex,
            selectCallback: ((selectMenuIndex) {
              print(
                  "selected filterItem index = $itemIndex, bloc = ${context.read<CourseListBloc>()}");
              CourseOverlayEntryPage.dismiss();
              context.read<CourseListBloc>().add(
                  FilterSelectedIndexChangedEvent(selectMenuIndex, itemIndex));
            })));
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget(
      {required this.tabController,
      required this.tabs,
      super.key,
      this.selectChanged});

  final TabController tabController;
  final ValueChanged? selectChanged;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
      height: 60.h,
      child: TabBar(
        controller: tabController,
        onTap: selectChanged,
        tabs: tabs,
        isScrollable: true,
        labelColor: AppColors.primaryColor,
        labelStyle: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w500),
        unselectedLabelColor: Colors.black,
        indicator: const UnderlineTabIndicator(
            insets: EdgeInsets.symmetric(horizontal: 10),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 3.0)
            // borderRadius: BorderRadius.zero
            ),
      ),
    );
  }
}

typedef CourseFilterItemSelect = void Function(int index);

class CourseFilter extends StatelessWidget {
  const CourseFilter({super.key, this.filterItemSelect, required this.titles});

  final CourseFilterItemSelect? filterItemSelect;

  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: titles
            .asMap()
            .map((index, title) {
              // List<Map<String, dynamic>> cTabList = CourseListFilters[index];
              // Map<String, dynamic> cSelectedItem = cTabList[selectedIndex];
              // List<String> menus =
              // cTabList.map((e) => e['title'] as String).toList();
              return MapEntry(
                  index,
                  FilterTab(
                    title: title,
                    onTap: () => filterItemSelect?.call(index),
                  ));
            })
            .values
            .toList(),
      ),
    );
  }

  void _showDropDownList(List<String> menus, int selectedIndex,
      BuildContext context, int filterMenuIndex) {
    CourseOverlayEntryPage.showPages(
        context: context,
        container: CourseOverlayContainerPage(
            menus: menus,
            selectedIndex: selectedIndex,
            selectCallback: ((index) {
              print(
                  "selected index = $index, bloc = ${context.read<CourseListBloc>()}");
              context
                  .read<CourseListBloc>()
                  .add(FilterSelectedIndexChangedEvent(filterMenuIndex, index));
            })));

    //   if (isShowDrop) {
    //     isShowDrop = false;
    //     _overlayEntry.remove();
    //     // return;
    //   }

    //   final box = blocContext.findRenderObject() as RenderBox;
    //   final dy = box.localToGlobal(Offset(0, box.size.height)).dy;

    //   isShowDrop = true;
    //   _overlayEntry = OverlayEntry(
    //       builder: (context) => Positioned.fill(
    //           top: dy,
    //           child: Material(
    //             color: const Color(0x55000000),
    //             child: Column(
    //               children: [
    //                 Container(
    //                   color: Colors.white,
    //                   constraints:
    //                       BoxConstraints.expand(height: 51.0 * menus.length),
    //                   child: DropDownList(
    //                       menus: menus,
    //                       selectedIndex: selectedIndex,
    //                       onTap: (index) {
    //                         print(
    //                             "selected index = $index, bloc = ${blocContext.read<CourseListBloc>()}");
    //                         blocContext.read<CourseListBloc>().add(
    //                             FilterSelectedIndexChangedEvent(
    //                                 filterMenuIndex, index));

    //                         _overlayEntry.remove();
    //                         isShowDrop = false;
    //                       }),
    //                 ),
    //                 Expanded(child: GestureDetector(
    //                   onTap: () {
    //                     _overlayEntry.remove();
    //                     isShowDrop = false;
    //                   },
    //                 ))
    //               ],
    //             ),
    //           )));

    //   Overlay.maybeOf(context)?.insert(_overlayEntry);
  }
}

class CourseOverlayContainerPage extends StatelessWidget {
  const CourseOverlayContainerPage(
      {super.key,
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

  factory CourseOverlayEntryPage.fromPosition(
      {Rect rect = const Rect.fromLTRB(0, 0, 0, 0),
      Color? color = const Color(0x55000000),
      Widget? container,
      OnTapEntryBackground? tapEntryBackground}) {

    return CourseOverlayEntryPage(
        builder: (context) => Positioned.fill(
              top: rect.top,
              child: GestureDetector(
                onTap: tapEntryBackground,
                child: Material(
                  color: color,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.redAccent,
                      ),
                      container ?? Container()
                    ],
                  ),
                ),
              ),
            )
    );
  }

  static CourseOverlayEntryPage? _overlayEntryPage;

  static showPages(
      {bool show = true,
      required BuildContext context,
      Widget? container,
      Rect? rect}) {

    if (!show) {
      dismiss();
      return;
    }
    // 如果正在显示则先移除
    dismiss();


    print("state = ");

    _overlayEntryPage = CourseOverlayEntryPage.fromPosition(
        rect: rect ?? Rect.zero,
        container: container,
        tapEntryBackground: () => dismiss());



    OverlayState? state = Overlay.maybeOf(context);
    print("state = $state");

    Overlay.maybeOf(context)?.insert(_overlayEntryPage!);
  }

  static void dismiss() {
    _overlayEntryPage?.remove();
  }
}

class FilterTab extends StatelessWidget {
  const FilterTab({super.key, required this.title, this.onTap});

  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: AppFontSize.normalSp, color: AppColors.black),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Icon(
                  CNWFonts.down,
                  size: 32.sp,
                  color: Colors.black,
                ))
          ],
        ));
  }
}

class CourseTabPages extends StatelessWidget {
  const CourseTabPages({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListBloc, CourseListState>(
        builder: ((context, state) {
      return Expanded(
          child: TabBarView(
        controller: tabController,
        children: state.tabs
                ?.map((e) => Container(
                      color: Colors.amberAccent,
                    ))
                .toList() ??
            [],
      ));
    }));
  }
}
