import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../utilities/constants.dart';
import '../exceptions/weather_exception.dart';
import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    //URI stands for Uniform Resource Identifier.
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost, //in constant.dart file
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );
    debugPrint('URI = $uri');
    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of $city');
      }

      final directGeocoding = DirectGeocoding.fromJson(responseBody);

      return directGeocoding;
    } catch (e, stackTrace) {
      debugPrint('Error: ${e.runtimeType} stackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    // debugPrint('directGeocoding.lat = ${directGeocoding.lat}');
    // debugPrint('directGeocoding.lat = ${directGeocoding.lon}');
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.latProperty}',
        'lon': '${directGeocoding.lonProperty}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );
    debugPrint('This is the uri API call: $uri');

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);
      debugPrint('This is weatherJson: $weatherJson');

      final Weather weather = Weather.fromJson(weatherJson);
      debugPrint('This is the JSON response for weather: $weather');
      return weather;
    } catch (e, stackTrace) {
      debugPrint('Error: ${e.runtimeType} stackTrace: $stackTrace');
      rethrow;
    }
  }
}
