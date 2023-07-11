part of 'index_bloc.dart';


abstract class IndexEvent extends Equatable {
  const IndexEvent();

  @override
  List<Object> get props => [];
}

// 加载数据事件
class IndexEventLoadData extends IndexEvent {
  const IndexEventLoadData();
}

// 切换index事件
class SelectedIndexChangeEvent extends IndexEvent {
  const SelectedIndexChangeEvent(this.selectedIndex);
  final int selectedIndex;
}


// grade model 改变事件
class GradeModuleChangedEvent extends IndexEvent {
  const GradeModuleChangedEvent(this.pageModule);

  final PageModule pageModule;
}