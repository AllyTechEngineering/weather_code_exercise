import 'package:flutter/foundation.dart';

import '../blocs/temp_settings/temp_settings_bloc.dart';

class ShowTemperatureAndWindClass {
  String showTemperatureResults(double temperature, var tempUnit) {
    if (tempUnit == TemperatureUnit.fahrenheitStatus) {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
    }
    return temperature.toStringAsFixed(2) + '℃';
  }

  String showWindSpeedResults(double windSpeed, var tempUnit) {
    if (tempUnit == TemperatureUnit.fahrenheitStatus) {
      return (windSpeed * 1.943844).toStringAsFixed(2) + ' kn';
    }
    return windSpeed.toStringAsFixed(2) + ' m/s';
  }
}
