import 'package:cniao/models/adbanner.dart';
import 'package:cniao/models/course.dart';
import 'package:cniao/models/grade.dart';
import 'package:cniao/models/page_module.dart';
import 'package:cniao/models/teacher.dart';
import 'package:cniao/pages/index/recommend/bloc/recommend_bloc.dart';
import 'package:cniao/pages/index/widget/course/course_list.dart';
import 'package:cniao/pages/index/widget/image_banner.dart';
import 'package:cniao/pages/index/widget/image_grid.dart';
import 'package:cniao/pages/index/widget/teacher_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

bool isSyncGradeModule = false;

// 推荐页
class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return BlocProvider(
      create: (context) {
        RecommendBloc bloc = RecommendBloc();
        bloc.add(const GetBannerEvent()); //发送事件
        bloc.add(const GetPageModuleEvent());
        return bloc;
      },
      child: BlocBuilder<RecommendBloc, RecommendState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: EasyRefresh.custom(
                slivers:  [
                   BannerSliver(banners: state.banners ?? [],),
                  ..._modulesSliver(state)
                ],
                header: BallPulseHeader(),
                onRefresh: () async {
                  //loadData
                  context.read<RecommendBloc>().add(const GetBannerEvent());
                },
                footer: MaterialFooter(overScroll: true),
              ));
        }
      ),
    );
  }

  List<Widget> _modulesSliver(RecommendState? state) {
    List<Widget> sliver = [];
    state?.modules?.forEach((module) {
      sliver.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(module.title ?? ""),
        ),
      ));
      sliver.add(_sliverForModule(module));
    });
    return sliver;
  }

  Widget _sliverForModule(PageModule module) {
    late Widget sliver;
    switch (RecommendType.values[module.type!]) {
      case RecommendType.teacher:
        sliver = _teacherWidget(module);
        break;
      case RecommendType.course:
        sliver = _courseWidget(module);
        break;
      case RecommendType.grade:
        sliver = _gradeWidget(module);
        break;
      default:
        break;
    }
    return sliver;
  }

  Widget _gradeWidget(PageModule module) {
    return ImageGrid(grades: module.datas as List<Grade>);
  }

  Widget _courseWidget(PageModule module) {
    return CourseList(courses: module.datas as List<Course>);
  }

  Widget _teacherWidget(PageModule module) {
    return  SliverToBoxAdapter(
        child: TeacherSwiper(
      teachers: module.datas as List<Teacher>,
    ));
  }

  @override
  bool get wantKeepAlive => true;
}

class BannerSliver extends StatelessWidget {
  const BannerSliver({super.key, required this.banners});
  final List<AdBanner>banners;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ImageBanner(banners: banners,
        ),
    );
  }
}
