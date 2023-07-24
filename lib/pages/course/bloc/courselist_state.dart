

part of 'courselist_bloc.dart';


class FliterItemState {

  final int selectedIndex;
  final bool isSelected; //是否选中状态

  const FliterItemState({this.selectedIndex = 0, this.isSelected = false});

  FliterItemState copyWith ({int? selectedIndex, bool? isSelected}) {
    return FliterItemState(selectedIndex: selectedIndex ?? this.selectedIndex, isSelected: isSelected ?? this.isSelected);
  }

  @override
  String toString() {
    return "selectedIndex = $selectedIndex, isSelected = $isSelected";
  }
}

class CourseListState extends Equatable {
  const CourseListState({
    this.tabs,
    this.selectedTabIndex = 0,
    this.filterSelectedIndexs = const [FliterItemState(), FliterItemState(), FliterItemState(), FliterItemState()],
  });

  final List<CourseFirstCategory>? tabs; // 课程分类
  final int selectedTabIndex;           // 分类选择index
  final List<FliterItemState> filterSelectedIndexs; // 过滤选择index

  CourseListState copyWith({
    List<CourseFirstCategory>? tabs,
    int? selectedTabIndex,
    List<FliterItemState>? filterSelectedIndexs,
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
