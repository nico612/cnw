

import 'package:cniao/models/course.dart';
import 'package:cniao/pages/index/widget/course/course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseList extends StatelessWidget {
  const CourseList({super.key, required this.courses});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList( // 适用与固定高item的list
      delegate: SliverChildBuilderDelegate((context, index) {
        return CourseItem(
            course: courses[index],
            onTap: (course) {
              print(course.name);
            },
        );
      },
      childCount: courses.length
      ),
      itemExtent: 210.h,
    );
  }
}
