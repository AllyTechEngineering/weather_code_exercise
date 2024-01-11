import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_stream_bloc/models/custom_error.dart';
import 'package:open_weather_stream_bloc/models/weather.dart';
import 'package:open_weather_stream_bloc/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  // final variable to hold an instance of WeatherRepository.
  // This is injected through the constructor.
  WeatherBloc({required this.weatherRepository}) : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
    // Registers an event handler for the FetchWeatherEvent type. When a FetchWeatherEvent is dispatched,
    // it will trigger the _fetchWeather method.
  }

  Future<void> _fetchWeather(
    // Takes a FetchWeatherEvent and an Emitter<WeatherState> as parameters.
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loadingStatus));
    // Updates the state to indicate that weather data is currently being loaded

    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      // tries to fetch weather data using the repository method fetchWeather for the user request city.

      // if successful, updates the state with loaded weather data and sets status to loaded.
      emit(
        state.copyWith(
          status: WeatherStatus.loadedStatus,
          weather: weather,
        ),
      );
      // try-catch block used for handling exceptions
      // CustomError is the type of exception that this catch block is handling.
      // If the code within the try block throws an exception of type CustomError, this block will be executed.
      // catch (e) catches the exception and assigns it to variable e.
      // CustomError class implements the Exception interface.
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          // updates the status
          status: WeatherStatus.errorStatus,
          // error: e, updates the error property of the new state with the caught exception (e).
          // This allows storing information about the error, such as an error message or additional details,
          // in the state.
          error: e,
        ),
      );
    }
  }
}
