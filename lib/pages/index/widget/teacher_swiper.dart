

import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/models/course.dart';
import 'package:cniao/models/teacher.dart';
import 'package:cniao/pages/index/widget/course/course_item.dart';
import 'package:cniao/pages/index/widget/custom_swipe.dart';
import 'package:cniao/utils/utils_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherSwiper extends StatelessWidget {

  const TeacherSwiper({super.key, required this.teachers});

  final List<Teacher> teachers;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double leftOffsetWidth = screenWidth / 5 / 2;

    List<Color> colors = teachers.map((e) {
          Random random = Random();
          int r = random.nextInt(256); // 生成0-255之间的红色分量
          int g = random.nextInt(256); // 生成0-255之间的绿色分量
          int b = random.nextInt(256); // 生成0-255之间的蓝色分量
          return Color.fromARGB(255, r, g, b);
      }).toList();

    return Container(
      height: 750.h,
      color: Colors.redAccent,
      child: CustomSwipe(
        children: teachers.map((e) => TeacherCellWidget(teacher: e)).toList(),
      )
    );
  }
}

class TeacherCellWidget  extends StatelessWidget {
  const TeacherCellWidget({super.key, required this.teacher});
  final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        _TeacherCellHeader(teacher: teacher),
        _TeacherCourse(courses: teacher.courses ?? [],),
      ],
    );
  }
}


class _TeacherCourse extends StatelessWidget {
  const _TeacherCourse({super.key, required this.courses});
  final List<Course> courses;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CourseItem(course: courses[index]);
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: courses.length,
        itemExtent: 210.h,
      ),
    );
  }
}


class _TeacherCellHeader extends StatelessWidget {
  const _TeacherCellHeader({super.key, required this.teacher});
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              color: AppColors.greyLight,
              child: Image.network(
                UtilsString.fixedHttpStart(teacher.logoUrl ?? ""),
                width: 120.w,
                height: 120.w,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
                teacher.teacherName ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              teacher.company ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }
}


