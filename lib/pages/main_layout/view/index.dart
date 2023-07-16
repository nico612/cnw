
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/pages/course/view/index.dart';
import 'package:cniao/pages/index/view/index.dart';
import 'package:cniao/pages/main_layout/cubil/tab_cubit.dart';
import 'package:cniao/pages/profile/view/index.dart';
import 'package:cniao/pages/study_center/view/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


final List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    icon: Image.asset("assets/home/index.png", width: 70.w, height: 70.h,),
    activeIcon: Image.asset("assets/home/index_selected.png", width: 70.w, height: 70.h),
    label: "首页",
    ),
  BottomNavigationBarItem(
    icon: Image.asset("assets/home/index.png", width: 70.w, height: 70.h,),
    activeIcon: Image.asset("assets/home/index_selected.png", width: 70.w, height: 70.h),
    label: "课程",
    ),
  BottomNavigationBarItem(
    icon: Image.asset("assets/home/index.png", width: 70.w, height: 70.h,),
    activeIcon: Image.asset("assets/home/index_selected.png", width: 70.w, height: 70.h),
    label: "学习",
    ),
  BottomNavigationBarItem(
    icon: Image.asset("assets/home/index.png", width: 70.w, height: 70.h,),
    activeIcon: Image.asset("assets/home/index_selected.png", width: 70.w, height: 70.h),
    label: "我的",
    ),

];


final pages = [
  IndexPage(),
  CourseListPage(),
  const StudyCenterPage(),
  const ProfilePage()
];


final PageController _pageController = PageController();


class MainLayout extends StatelessWidget {

  const MainLayout({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const MainLayout());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabCubit(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<TabCubit, int>(
          buildWhen: (pre, curr) {
            return pre != curr;
          },
          builder: (context, state) {
            return CupertinoTabBar(
              items: bottomNavItems,
              currentIndex: state,
              activeColor: AppColors.primaryColor,
              inactiveColor: const Color(0xff606266),
              onTap: (index) => _onTabChanged(context, index),
              );
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
    );
  }

  void _onTabChanged(BuildContext context, int index) {
      context.read<TabCubit>().update(index); //更新点击事件
      _pageController.jumpToPage(index);
  }
}

