
part of 'index_bloc.dart';


class IndexState extends Equatable {

  const IndexState({
    this.tabs = const ['推荐', '免费课程', '实战课程', '就业课'],
    this.selectedIndex = 0,
    this.gradeModule
  });

  IndexState copyWith({
    List<String>? tabs,
    int? selectedIndex,
    PageModule? gradeModule
  }) {
    return IndexState(
      tabs: tabs ?? this.tabs, 
      selectedIndex: selectedIndex ?? this.selectedIndex, 
      gradeModule: gradeModule ?? gradeModule
      );
  }

  final int selectedIndex;
  final List<String> tabs;
  final PageModule? gradeModule;


  @override
  List<Object?> get props => [selectedIndex, tabs, gradeModule ?? ""];

}