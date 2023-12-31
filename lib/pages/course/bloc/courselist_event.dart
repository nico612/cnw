
part of 'courselist_bloc.dart';

abstract class CourseListEvent extends Equatable {

  const CourseListEvent();

 @override
  List<Object> get props => [];
}


// 获取分类事件
class GetCategoriesEvent extends CourseListEvent {

  const GetCategoriesEvent();
}

// 分类栏点击事件
class SelectedTabIndexChangedEvent extends CourseListEvent {
  const SelectedTabIndexChangedEvent(this.selectedTabIndex);
  final int selectedTabIndex;
}

// fliter button 点击事件
class FilterItemSelectedEvent extends CourseListEvent {
  const FilterItemSelectedEvent(this.index);
  final int index;
}


// 条件list选择事件
class FilterSelectedIndexChangedEvent extends CourseListEvent {
  const FilterSelectedIndexChangedEvent(this.index, this.value);
  final int index;  // 过滤按钮选择index
  final int value;  // 过滤条件选择index
}

