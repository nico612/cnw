import 'package:cniao/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
