

part of 'courselist_bloc.dart';

class CourseListState extends Equatable {
  const CourseListState({
    this.tabs,
    this.selectedTabIndex = 0,
    this.filterSelectedIndexs = const [0, 0, 0, 0],
  });

  final List<CourseFirstCategory>? tabs; // 课程分类
  final int selectedTabIndex;           // 分类选择index
  final List<int> filterSelectedIndexs; //过滤选择index

  CourseListState copyWith({
    List<CourseFirstCategory>? tabs,
    int? selectedTabIndex,
    List<int>? filterSelectedIndexs,
  }) {
    return CourseListState(
      tabs: tabs ?? this.tabs,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      filterSelectedIndexs: filterSelectedIndexs ?? this.filterSelectedIndexs,
    );
  }

  @override
  List<Object> get props => [
        tabs ?? "",
        selectedTabIndex,
        filterSelectedIndexs,
      ];
}
