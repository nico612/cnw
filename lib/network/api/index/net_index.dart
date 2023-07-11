// 获取首页 轮播图
import 'package:cniao/models/adbanner.dart';
import 'package:cniao/network/http/net_manager.dart';

const String net_index_path_bannerlist = '/cms/banner/list';
// 获取首页的模块列表
const String net_index_path_modulelist = '/allocation/module/list';
// 获取首页模块详情
const String net_index_path_componentlist = '/allocation/component/list';


class IndexNetManager {
  // 首页banner 图接口
  static Future<dynamic> bannerList({int? type, int? pageShow}) async {
    Map<String, dynamic> queryParameters = {};
    if (type != null) queryParameters['type'] = type;
    if (pageShow != null) queryParameters['page_show'] = pageShow;
    return HttpNetManager.get(net_index_path_bannerlist, params: queryParameters);
  }
}