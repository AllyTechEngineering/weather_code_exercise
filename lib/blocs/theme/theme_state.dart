part of 'theme_bloc.dart';

enum AppTheme {
  light,
  dark,
}

/// Here are a few reasons why Equatable is commonly used in Flutter BLoC:
/// Efficient State Comparison: in a BLoC, states often change, triggering widget rebuilds. To determine if a state has changed, Flutter needs to compare the new state with the previous one. Equatable helps generate efficient equality checks for objects by overriding the == operator and hashCode method, making the comparison process faster.
/// Avoiding Boilerplate Code: without Equatable, developers would need to manually override the == operator and hashCode method for each state class to ensure accurate equality comparisons. Equatable simplifies this process by providing a convenient way to create value-based equality checks with less boilerplate code.
/// Improved Readability: using Equatable can lead to more readable code, as it abstracts away the details of equality checking and allows developers to focus on the actual content of the state.
class ThemeState extends Equatable {
  final AppTheme appTheme;
  ThemeState({
    this.appTheme = AppTheme.light,
  });

  factory ThemeState.initial() {
    return ThemeState();
  }

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';

  //The copyWith pattern is especially prevalent in Flutter for managing state in widgets or other classes. It is a way to create a new instance of an object with some fields updated while keeping the original object immutable.
  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
