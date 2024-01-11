part of 'weather_bloc.dart';

// enum is a special kind of class
// represent a fixed set of constant values (enumerators) within a single type
enum WeatherStatus {
  initialStatus,
  loadingStatus,
  loadedStatus,
  errorStatus,
}

/// Here are a few reasons why Equatable is commonly used in Flutter BLoC:
/// Efficient State Comparison: in a BLoC, states often change, triggering widget rebuilds. To determine if a state has changed, Flutter needs to compare the new state with the previous one. Equatable helps generate efficient equality checks for objects by overriding the == operator and hashCode method, making the comparison process faster.
/// Avoiding Boilerplate Code: without Equatable, developers would need to manually override the == operator and hashCode method for each state class to ensure accurate equality comparisons. Equatable simplifies this process by providing a convenient way to create value-based equality checks with less boilerplate code.
/// Improved Readability: using Equatable can lead to more readable code, as it abstracts away the details of equality checking and allows developers to focus on the actual content of the state.

class WeatherState extends Equatable {
  // Properties:
  final WeatherStatus statusProperty;
  final Weather weatherProperty;
  final CustomError errorProperty;
  // Constructor - initializes the fields
  WeatherState({
    required this.statusProperty,
    required this.weatherProperty,
    required this.errorProperty,
  });
// creates the initial state
  factory WeatherState.initial() {
    return WeatherState(
      statusProperty: WeatherStatus.initialStatus,
      weatherProperty: Weather.initial(),
      errorProperty: CustomError(),
    );
  }
// Overrides the props getter from Equatable to specify which properties should be used for equality checking.
  @override
  List<Object> get props => [statusProperty, weatherProperty, errorProperty];

  // An example of how to use toString to debug
  // WeatherState currentState = WeatherState(
  // status: WeatherStatus.loaded,
  // weather: Weather(/* some weather data */),
  // error: CustomError(/* some error details */),
  // );
  // print(currentState.toString());
  // output would be:
  // WeatherState(status: loaded, weather: Weather(/* some weather data */), error: CustomError(/* some error details */))
  @override
  String toString() =>
      'WeatherState(status: $statusProperty, weather: $weatherProperty, error: $errorProperty)';

  //The copyWith pattern is especially prevalent in Flutter for managing state in widgets or other classes. It is a way to create a new instance of an object with some fields updated while keeping the original object immutable.
  // Implements the copyWith pattern for immutability.
  // It allows creating a new instance with updated values while keeping the original instance unchanged.
  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      statusProperty:
          status ?? this.statusProperty, // The ?? operator is the null-aware coalescing operator.
      // It's used to provide a default value when the expression on its left side evaluates to null.
      weatherProperty: weather ?? this.weatherProperty,
      errorProperty: error ?? this.errorProperty,
    );
  }
}
