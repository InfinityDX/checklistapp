import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(const PageState());

  void changePageTo(PageType type) {
    emit(state.copyWith(type: type));
  }
}
