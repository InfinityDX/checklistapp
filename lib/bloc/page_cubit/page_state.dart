part of 'page_cubit.dart';

enum PageType { dashboard, calendar, settings }

class PageState extends Equatable {
  final PageType type;
  const PageState({this.type = PageType.dashboard});

  PageState copyWith({
    PageType? type,
  }) {
    return PageState(
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [type];
}
