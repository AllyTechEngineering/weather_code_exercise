import '../exceptions/weather_exception.dart';
import '../models/custom_error.dart';
import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  // Required parameterized constructor that takes an instance of WeatherApiServices. This dependency injection allows the repository to use the external service for fetching weather data.
  final WeatherApiServices weatherApiServices; //in weather_api_services.dart
  WeatherRepository({
    required this.weatherApiServices,
  });

  // get weather data by city
  // Note that OpenWeatherMap is deprecating acquiring weather by city name, zip codes or city ID.
  // Instead, they suggest that you use their geocoding API with a city to get lat and lon via their API
  // Here is an example to get the lat and lon for Dubai:
  // https://api.openweathermap.org/geo/1.0/direct?q=Dubai&limit=1&appid= API key not shown.
  // The response included that lat and lon.
  // Now I request the weather for Dubai and here is and example of that call:
  // https://api.openweathermap.org/data/2.5/weather?lat=25.2653471&lon=55.2924914&units=metric&appid=
  // lat and lon are now used in the API to get the weather information for the city requested.
  Future<Weather> fetchWeather(String city) async {
    try {
      // gets the city lat and lon
      final DirectGeocoding directGeocoding = await weatherApiServices.getDirectGeocoding(city);
      // uses the lat and lon of the city to get the weather
      final Weather tempWeather = await weatherApiServices.getWeather(directGeocoding);

      // adds the updated city and country - why only these two properties?
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
