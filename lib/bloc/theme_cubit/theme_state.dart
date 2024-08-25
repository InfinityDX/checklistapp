part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final Color color;
  const ThemeState({
    this.mode = ThemeMode.light,
    this.color = Colors.deepPurple,
  });

  ThemeState copyWith({
    ThemeMode? mode,
    Color? color,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      color: color ?? this.color,
    );
  }

  @override
  List<Object> get props => [mode, color];
}
