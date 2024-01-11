import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_stream_bloc/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:open_weather_stream_bloc/utilities/show_temperature_and_wind.dart';

void main() {
  group('show temperature results in F and C and metric/imperial wind speed results', () {
    test('show temperature f results', () {
      //Arrange
      var tempUnit = TemperatureUnit.fahrenheitStatus;
      double temperature = 0.0;
      //Act
      String temperatureResults =
          ShowTemperatureAndWindClass().showTemperatureResults(temperature, tempUnit);
      //Assert
      expect(temperatureResults, '32.00℉');
    });
    test('show temperature c results', () {
      //Arrange
      var tempUnit = TemperatureUnit.celsiusStatus;
      double temperature = 32.0;
      //Act
      String temperatureResults =
          ShowTemperatureAndWindClass().showTemperatureResults(temperature, tempUnit);
      //Assert
      expect(temperatureResults, '32.00℃');
    });
    test('show for input 1 the metric wind speed results', () {
      //Arrange
      var tempUnit = TemperatureUnit.celsiusStatus;
      double windSpeed = 1.0;
      //Act
      String windSpeedResults =
          ShowTemperatureAndWindClass().showWindSpeedResults(windSpeed, tempUnit);
      //Assert
      expect(windSpeedResults, '1.00 m/s');
    });
    test('show for input 1 the knot wind speed results', () {
      //Arrange
      var tempUnit = TemperatureUnit.fahrenheitStatus;
      double windSpeed = 1.0;
      //Act
      String windSpeedResults =
          ShowTemperatureAndWindClass().showWindSpeedResults(windSpeed, tempUnit);
      //Assert
      expect(windSpeedResults, '1.94 kn');
    });
    test('show for input 10 the metric wind speed results', () {
      //Arrange
      var tempUnit = TemperatureUnit.celsiusStatus;
      double windSpeed = 10.0;
      //Act
      String windSpeedResults =
          ShowTemperatureAndWindClass().showWindSpeedResults(windSpeed, tempUnit);
      //Assert
      expect(windSpeedResults, '10.00 m/s');
    });
    test('show for input 10 the knot wind speed results', () {
      //Arrange
      var tempUnit = TemperatureUnit.fahrenheitStatus;
      double windSpeed = 10.0;
      //Act
      String windSpeedResults =
          ShowTemperatureAndWindClass().showWindSpeedResults(windSpeed, tempUnit);
      //Assert
      expect(windSpeedResults, '19.44 kn');
    });
  });
}
