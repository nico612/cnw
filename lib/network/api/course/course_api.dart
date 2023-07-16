import 'package:cniao/models/course.dart';
import 'package:cniao/models/course_first_category.dart';
import 'package:cniao/models/pagination.dart';
import 'package:cniao/network/http/net_manager.dart';

// 课程详情
const String net_coursedetail_path_detail = '/course/detail';

// 课程章节列表
const String net_coursedetail_path_lessions = '/courses/lessons';

// 课程评价列表
const String net_coursedetail_path_comments = '/comment/list';

// 获取课程分类
const String net_course_path_category = '/courses/category';

// 获取课程列表
const String net_course_path_courselist = '/courses';

// 课程的最后一次学习记录
const String net_course_last_playinfo = '/course/last/playinfo';

class CourseApi {
  static Future<Pagination<List<Course>>> courseList(
      Map<String, dynamic> params) {
    return HttpNetManager.get(net_course_path_courselist, params: params)
        .then((response) {
      return Pagination<List<Course>>.fromJson(response, (datas) {
        return List<Map<String, dynamic>>.from(datas)
            .map((e) => Course.fromJson(e))
            .toList();
      });
    });
  }

  static Future<List<CourseFirstCategory>> courseCategory() {

    return HttpNetManager.get(net_course_path_category).then((value) {

        // List<Map<String, dynamic>> datas = value as List<Map<String, dynamic>>;

        return List<Map<String, dynamic>>.from(value).map((e ) => CourseFirstCategory.fromJson(e)).toList();
    });
  }
}
