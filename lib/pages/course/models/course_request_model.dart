


import 'package:cniao/models/base_request_list_mode.dart';

class CourseRequestModel extends BaseRequestListMode {

  final int? courseType;    // 课程类型：全部为空， 商业实战：3， 专业好课：1
  final String? sortField;  //排序： 全部为空，时间：time， 评价最高 comment, 学习最多：study
  final int? free;     // 是否免费, -1 为全部
  final int? category;    //分类id，如：全部为0 或 空，andorid、flutter，等根据category接口获取，id就是种类
  final String? code;     // all
  final int? difficulty;  // 难度：全部为空，初级、中级、高级、架构为 1 ～ 4



  const CourseRequestModel({super.page, super.size, this.courseType, this.sortField = "time", this.free, this.category, this.code, this.difficulty});

  CourseRequestModel copyWith({int? page, int? size, int? courseType, String? sortField, int? free, int? category, String? code, int? difficulty}) {

    return CourseRequestModel(
      page: page ?? this.page,
      size: size ?? this.size,
      courseType: courseType ?? this.courseType,
      sortField: sortField ?? this.sortField,
      free: free ?? this.free,
      category: category ?? this.category,
      code: code ?? this.code,
      difficulty: difficulty ?? this.difficulty
    );
  }

  @override
  
  Map<String, dynamic> get params {
    final p = super.params;
    if (courseType != null) p["course_type"] = courseType;
      if (sortField != null) p["sort_field"] = sortField;
      if (free != null) p["is_free"] = free;
      if (category != null) p["category"] = category;
      if (code != null) p["code"] = code;
      return p;
  }
}
