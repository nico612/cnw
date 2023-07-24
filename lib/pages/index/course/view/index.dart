

import 'package:carousel_slider/carousel_state.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/common/view/sep_divider.dart';
import 'package:cniao/pages/course/models/course_request_model.dart';
import 'package:cniao/pages/index/course/bloc/course_bloc.dart';
import 'package:cniao/pages/index/widget/course/course_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CoursePage extends StatefulWidget {

  const CoursePage({super.key, required this.requestModel, required this.courseBloc});

  final CourseRequestModel requestModel;
  final CourseBloc courseBloc;

  @override
  State<CoursePage> createState() => _CoursePageState();

}

class _CoursePageState extends State<CoursePage> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    _loadData(widget.requestModel);
    print("init state");
    super.initState();
  }

  void _loadData(CourseRequestModel requestModel) {
    widget.courseBloc.add(GetDataEvent(requestModel: requestModel));
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<CourseBloc>(
      create: (context) => widget.courseBloc,

      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: EasyRefresh.custom(
                header: BallPulseHeader(),
                footer: BallPulseFooter(),
                slivers: [
                  CourseList(courses: state.courses),
                  SliverToBoxAdapter(
                    child: state.noMore 
                    ? const SepDivider(text: Text("人家也是有底线的", style: TextStyle(fontSize: 12, color: AppColors.gray),)) 
                    : Container()
                  )
                ],
                onRefresh: () async {
            
                  _loadData(widget.requestModel.copyWith(page: 1));
                },
                onLoad: () async {
                  _loadData(widget.requestModel.copyWith(page: widget.requestModel.page + 1));
                },
                ),
            );
        },
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => false;
  
}