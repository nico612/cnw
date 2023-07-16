
import 'dart:async';

import 'package:cniao/models/base_request_list_mode.dart';
import 'package:cniao/models/course.dart';
import 'package:cniao/models/pagination.dart';
import 'package:cniao/network/api/course/course_api.dart';
import 'package:cniao/pages/course/models/course_request_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_event.dart';
part 'course_state.dart';


class CourseBloc extends Bloc<CourseEvent, CourseState> {

  CourseBloc() : super(const CourseState()) {
    on(_getData);
  }

  Future<FutureOr<void>> _getData(GetDataEvent event, Emitter<CourseState> emitter) async {

    emitter(state.copyWith(isLoading: true));

    Pagination<List<Course>> pagination = await CourseApi.courseList(event.requestModel.params);

    List<Course> courses = pagination.datas;

    if (event.requestModel.page > 1) {
        courses.insertAll(0, state.courses);
    }

    // courses.addAll(state.courses);

    emitter(state.copyWith(
        courses: courses,
        isLoading: false,
        noMore: pagination.page >= pagination.totalPage
      ));

  }
}