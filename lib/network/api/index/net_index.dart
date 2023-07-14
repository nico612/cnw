// 获取首页 轮播图
import 'package:cniao/models/adbanner.dart';
import 'package:cniao/models/course.dart';
import 'package:cniao/models/grade.dart';
import 'package:cniao/models/page_module.dart';
import 'package:cniao/models/teacher.dart';
import 'package:cniao/network/http/net_manager.dart';
import 'package:cniao/pages/index/recommend/bloc/recommend_bloc.dart';
import 'package:encrypt/encrypt.dart';

const String net_index_path_bannerlist = '/cms/banner/list';
// 获取首页的模块列表
const String net_index_path_modulelist = '/cms/page/1';



class IndexNetManager {
  // 首页banner 图接口
  static Future<List<AdBanner>> bannerList({int? type, int? pageShow}) async {
    Map<String, dynamic> queryParameters = {};
    if (type != null) queryParameters['type'] = type;
    if (pageShow != null) queryParameters['page_show'] = pageShow;

    return HttpNetManager
        .get(net_index_path_bannerlist, params: queryParameters)
        .then((value) => List<Map<String, dynamic>>.from(value).map((e) => AdBanner.fromJson(e)).toList());
  }

  static Future<List<PageModule>> moduleList() async {
    return HttpNetManager.get(net_index_path_modulelist)
        .then((value) {
          List<PageModule> modules = List<Map<String, dynamic>>.from(value).map((e) => PageModule.fromJson(e)).toList();
          List<PageModule> newModules = [];
          // 内部data模型
          for (var pageModel in modules) {
            // var newPageModel = pageModel;
              switch (RecommendType.values[pageModel.type!]) {
                case RecommendType.course:
                  pageModel = pageModel.copyWith(datas: pageModel.datas?.map((e) => Course.fromJson(e)).toList());
                  break;
                case RecommendType.grade:
                  pageModel = pageModel.copyWith(datas: pageModel.datas?.map((e) => Grade.fromJson(e)).toList());
                  break;
                case RecommendType.teacher:
                  pageModel = pageModel.copyWith(datas: pageModel.datas?.map((e) => Teacher.fromJson(e)).toList());
                  break;
                default:
                  break;
              }
              newModules.add(pageModel);
          }

          return newModules;
    });
  }
}