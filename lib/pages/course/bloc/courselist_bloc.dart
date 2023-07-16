


import 'dart:async';

import 'package:cniao/models/course_first_category.dart';
import 'package:cniao/network/api/course/course_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courselist_event.dart';
part 'courselist_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  CourseListBloc() : super(const CourseListState()) {

    on<GetCategoriesEvent>(_getCategories);

    // tab select
    on<SelectedTabIndexChangedEvent>((event, emit) =>
        emit(state.copyWith(selectedTabIndex: (event).selectedTabIndex)));

    //filter select
    on<FilterSelectedIndexChangedEvent>((event, emit) {
      List<int> indexs = List.from(state.filterSelectedIndexs);
      indexs[event.index] = event.value;
      emit(state.copyWith(filterSelectedIndexs: indexs));
    });
  }


  FutureOr<void> _getCategories(GetCategoriesEvent event, Emitter<CourseListState> emitter) async {
      //请求课程分类数据
    
      List<CourseFirstCategory> categories = await CourseApi.courseCategory();
      
      categories.insert(0, const CourseFirstCategory(code: "all", id: -1, title: "全部"));

      emitter(state.copyWith(tabs: categories));
  }

  // _getCategories(Emitter<CourseListState> emit) async {
  //   // 请求课程分类的数据
  //   List<Category> list = await CourseApi.courseCategory();

  //   List<Category> categories = [];

  //   categories.add(Category(code: 'all', id: -1, title: '全部'));
  //   categories.addAll(list);

  //   emit(state.copyWith(tabs: categories));
  // }
}
