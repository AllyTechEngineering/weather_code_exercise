import '../exceptions/weather_exception.dart';
import '../models/custom_error.dart';
import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding = await weatherApiServices.getDirectGeocoding(city);

      final Weather tempWeather = await weatherApiServices.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
        nameWeather: directGeocoding.nameProperty,
        countryWeather: directGeocoding.countryProperty,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(customErrorMessage: e.message); //message is in weather_exception.dart
    } catch (e) {
      throw CustomError(customErrorMessage: e.toString());
    }
  }
}
