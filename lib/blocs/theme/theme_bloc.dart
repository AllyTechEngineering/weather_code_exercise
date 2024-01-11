import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_stream_bloc/blocs/barrel_blocs.dart';
import 'package:open_weather_stream_bloc/utilities/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late final StreamSubscription weatherSubscription;

  final WeatherBloc weatherBloc;

  ThemeBloc({required this.weatherBloc}) : super(ThemeState.initial()) {
    weatherSubscription = weatherBloc.stream.listen((WeatherState weatherState) {
      if (weatherState.weatherProperty.tempWeather > kWarmOrNot) {
        add(ChangeThemeEvent(appTheme: AppTheme.light));
      } else {
        add(ChangeThemeEvent(appTheme: AppTheme.dark));
      }
    });
    on<ChangeThemeEvent>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }
  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
