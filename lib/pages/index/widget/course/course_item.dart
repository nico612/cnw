

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cniao/models/course.dart';
import 'package:cniao/utils/utils_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CourseTapCallback = void Function(Course course);


class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.course, this.onTap});
  final CourseTapCallback? onTap;
  final Course course;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap?.call(course);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: UtilsString.fixedHttpStart(course.imgUrl ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: Text(course.name ?? "",
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.black
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(course.firstCategory?.title ?? "", style: TextStyle(fontSize: 25.sp),),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(Icons.circle, color: Colors.grey, size: 5,),
                            ),
                            Text("${course.lessonsPlayedTime}", style: TextStyle(fontSize: 25.sp),),
                          ],
                        ),
                      ),
                      Container(
                        child: _coursePircesWidgets(course),
                      )
                    ],
            ),
                ))
          ],
        ),
      ),

    );
  }

  Widget _coursePircesWidgets(Course course) {
      late Widget widget;
      if (course.nowPrice == null || course.nowPrice! == 0.0) {
        widget = Text(
          "免费",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 25.sp
          ),
        );
      }else {
        widget = RichText(text: TextSpan(
          text: "¥",
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.red
          ),
          children: [
            TextSpan(
              text: "${course.nowPrice ?? 0}",
              style: TextStyle(fontSize: 25.sp, color: Colors.red)
            )
          ]
        ));
      }

      return widget;
  }


}
