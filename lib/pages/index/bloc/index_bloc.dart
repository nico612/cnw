

import 'dart:async';

import 'package:cniao/models/page_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'index_event.dart';
part 'index_state.dart';

// 处理顶部tab栏逻辑

class IndexBloc extends Bloc<IndexEvent, IndexState> {

  // 初始化状态
  IndexBloc() : super(const IndexState()) {
    // 监听Index改变事件
    on<SelectedIndexChangeEvent>(_changeSelectedIndex);
    on<GradeModuleChangedEvent>(_getGradModule);
  }

  FutureOr<void> _changeSelectedIndex(SelectedIndexChangeEvent event, Emitter<IndexState> emit)  {
      emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  FutureOr<void> _getGradModule(GradeModuleChangedEvent event, Emitter<IndexState> emit)  {
    emit(state.copyWith(gradeModule: event.pageModule));
  }

}
