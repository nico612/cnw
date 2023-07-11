

import 'package:card_swiper/card_swiper.dart';
import 'package:cniao/models/page_module.dart';
import 'package:cniao/pages/index/recommend/bloc/recommend_bloc.dart';
import 'package:cniao/pages/index/widget/image_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


bool isSyncGradeModule = false;

class RecommendPage extends StatefulWidget {

  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> with AutomaticKeepAliveClientMixin<RecommendPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) {
          RecommendBloc bloc = RecommendBloc();
          bloc.add(const GetBannerEvent());     //发送事件
          bloc.add(const GetPageModuleEvent());
          return bloc;
      },
      child: BlocBuilder<RecommendBloc, RecommendState>(
        builder: (context, state) {
          print("recommend BlocBuilder builder");
          return _mainContrainer(context, state);
        },
      ),
    );
  }

  Widget _mainContrainer(BuildContext context, RecommendState state) {
    List<Widget> slivers = [];
    slivers.add(_bannerSliver(state));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: EasyRefresh.custom(
        slivers: slivers,
        header: BallPulseHeader(),
        onRefresh: () async {
          //loadData
          context.read<RecommendBloc>().add(const GetBannerEvent());
        },
        footer: MaterialFooter(),
      ),
    );
  }

  Widget _bannerSliver(RecommendState state) {
    return SliverToBoxAdapter( //将普通控价转为可滑动的控件
      child: ImageBanner(banners: state.banners ?? [],)
    );
  }

  List<Widget> _modulesSliver(RecommendState state) {
    List<Widget> sliver = [];
    state.modules?.forEach((module) {
      sliver.addAll(_sliverForModule(module));
    });
    return sliver;
  }

  List<Widget> _sliverForModule(PageModule module) {
    switch (RecommendType.values[module.type!]) {
      case RecommendType.teacher:

        break;
      case RecommendType.course:
        break;
      case RecommendType.grade:
        break;
      default:
        break;
    }
      return [];
  }



  @override
  bool get wantKeepAlive => true;

}

