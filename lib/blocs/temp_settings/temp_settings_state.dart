part of 'temp_settings_bloc.dart';

enum TemperatureUnit {
  celsiusStatus,
  fahrenheitStatus,
}

/// Here are a few reasons why Equatable is commonly used in Flutter BLoC:
/// Efficient State Comparison: in a BLoC, states often change, triggering widget rebuilds. To determine if a state has changed, Flutter needs to compare the new state with the previous one. Equatable helps generate efficient equality checks for objects by overriding the == operator and hashCode method, making the comparison process faster.
/// Avoiding Boilerplate Code: without Equatable, developers would need to manually override the == operator and hashCode method for each state class to ensure accurate equality comparisons. Equatable simplifies this process by providing a convenient way to create value-based equality checks with less boilerplate code.
/// Improved Readability: using Equatable can lead to more readable code, as it abstracts away the details of equality checking and allows developers to focus on the actual content of the state.

class TempSettingsState extends Equatable {
  final TemperatureUnit
      temperatureUnit; // create a variable that can hold an instance of the TemperatureUnit enum.
  TempSettingsState({
    this.temperatureUnit = TemperatureUnit
        .celsiusStatus, // sets initial value used in the named factory constructor below
  });

  factory TempSettingsState.initial() {
    return TempSettingsState();
  }

  @override
  List<Object> get props => [temperatureUnit];
  // props getter returns a list of objects.
  // The list is used by Equatable to check equality

  @override
  String toString() => 'TempSettingsState(tempUnit: $temperatureUnit)';

//The copyWith pattern is especially prevalent in Flutter for managing state in widgets or other classes. It is a way to create a new instance of an object with some fields updated while keeping the original object immutable.
  TempSettingsState copyWith({
    TemperatureUnit? temperatureUnit,
  }) {
    //the ?? operator is the null-aware coalescing operator. It is used to provide a default value when the expression on its left side evaluates to null.
    return TempSettingsState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
    );
  }
}
