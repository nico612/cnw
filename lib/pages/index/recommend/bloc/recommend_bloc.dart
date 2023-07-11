
import 'dart:async';

import 'package:cniao/models/adbanner.dart';
import 'package:cniao/models/page_module.dart';
import 'package:cniao/network/api/index/net_index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "recommend_event.dart";
part 'recommend_state.dart';


// 列表类型
enum RecommendType {
  none,
  teacher, // 老师
  course, // 课程
  banner, // 轮播
  ad, // 广告
  grade, // 班级
  partner, // 合作伙伴
  contentblock, // 内容块
  icon, // 图标
  studentstory, // 学员故事
}

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {

  RecommendBloc() : super(const RecommendState()) {

    on<GetBannerEvent>(_getBanners);
    on<GetPageModuleEvent>(_getModules);
  }

  // 加载banner数据
  FutureOr<void> _getBanners(RecommendEvent event, Emitter<RecommendState> emitter) async {
    try {
        List list = await IndexNetManager.bannerList(type: 3, pageShow: 1);
        List<AdBanner> banners = List<Map<String, dynamic>>.from(list).map((e) => AdBanner.fromJson(e)).toList();
        emitter(state.copyWith(banners: banners)); //只有当state发生变化时，观察者才会重新build
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _getModules(RecommendEvent event, Emitter<RecommendState> emitter) {
    final List<PageModule> modules = [];
    emitter(state.copyWith(modules: modules));
  }
  

}