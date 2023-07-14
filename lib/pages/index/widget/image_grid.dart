

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cniao/common/application.dart';
import 'package:cniao/models/course.dart';
import 'package:cniao/models/grade.dart';
import 'package:cniao/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGrid extends StatelessWidget {

  final List<Grade> grades;

  const ImageGrid({super.key, required this.grades});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                Grade grade = grades[index];
                Course? gradeCourse = grade.course;
                return InkWell(
                  onTap: () {
                    Application.navigateTo(context, Routes.webViewPage,
                        params: {"url": gradeCourse?.h5site});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: gradeCourse?.imgUrl ?? "",
                    ),
                  ),
                );
              },
              childCount: grades.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              childAspectRatio: 16 / 9,
            )),
      ),
    );
  }

}
