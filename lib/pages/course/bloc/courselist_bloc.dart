


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
    on<SelectedTabIndexChangedEvent>((event, emit) {

        //去除filter选择状态
        List<FliterItemState> filterSelectedIndexs = state.filterSelectedIndexs.map((item) => item.copyWith(isSelected: false)).toList();

        emit(state.copyWith(selectedTabIndex: (event).selectedTabIndex, filterSelectedIndexs: filterSelectedIndexs));
    });
    

    //filter按钮点击事件
    on<FilterItemSelectedEvent>((event, emit) => emit(state.copyWith(
      filterSelectedIndexs: state.filterSelectedIndexs
      .asMap()
      .map((index, item) => event.index == index ? MapEntry(index, item.copyWith(isSelected: !item.isSelected) ) : MapEntry(index, item.copyWith(isSelected: false)))
      .values.
      toList())
    ));
    

    //filter select
    on<FilterSelectedIndexChangedEvent>((event, emit) {

      List<FliterItemState> indexs = List.from(state.filterSelectedIndexs);
      FliterItemState itemState = indexs[event.index];
      
      itemState = itemState.copyWith(selectedIndex: event.value, isSelected: false);
      indexs[event.index] = itemState;

      // TODU: 条件筛选后没有按钮没有更新
      for (var item in indexs) {
        print("item = ${item.toString()}");
      }
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
