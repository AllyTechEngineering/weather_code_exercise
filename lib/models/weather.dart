import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String descriptionWeather;
  final String iconWeather;
  final double tempWeather; //checked
  final double tempMinWeather;
  final double tempMaxWeather;
  final int pressureWeather; //checked
  final int humidityWeather; //checked
  final double speedWeather;
  final int degWeather;
  final String nameWeather;
  final String countryWeather;
  final DateTime lastUpdatedWeather;
  Weather({
    required this.descriptionWeather,
    required this.iconWeather,
    required this.tempWeather,
    required this.tempMinWeather,
    required this.tempMaxWeather,
    required this.pressureWeather,
    required this.humidityWeather,
    required this.speedWeather,
    required this.degWeather,
    required this.nameWeather,
    required this.countryWeather,
    required this.lastUpdatedWeather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];

    return Weather(
      descriptionWeather: weather['description'],
      iconWeather: weather['icon'],
      tempWeather: main['temp'],
      tempMinWeather: main['temp_min'],
      tempMaxWeather: main['temp_max'],
      pressureWeather: main['pressure'],
      humidityWeather: main['humidity'],
      speedWeather: wind['speed'],
      degWeather: wind['deg'],
      nameWeather: '',
      countryWeather: '',
      lastUpdatedWeather: DateTime.now(),
    );
  }

  factory Weather.initial() => Weather(
        descriptionWeather: '',
        iconWeather: '',
        tempWeather: 100.0,
        tempMinWeather: 100.0,
        tempMaxWeather: 100.0,
        pressureWeather: 0,
        humidityWeather: 0,
        speedWeather: 0.0,
        degWeather: 0,
        nameWeather: '',
        countryWeather: '',
        lastUpdatedWeather: DateTime(1970),
      );

  @override
  List<Object> get props {
    return [
      descriptionWeather,
      iconWeather,
      tempWeather,
      tempMinWeather,
      tempMaxWeather,
      pressureWeather,
      humidityWeather,
      speedWeather,
      degWeather,
      nameWeather,
      countryWeather,
      lastUpdatedWeather,
    ];
  }

  @override
  String toString() {
    return 'Weather(description: $descriptionWeather, icon: $iconWeather, temp: $tempWeather, tempMin: $tempMinWeather, tempMax: $tempMaxWeather, pressure: $pressureWeather, humidity: $humidityWeather,speed: $speedWeather, deg: $degWeather, name: $nameWeather, country: $countryWeather, lastUpdated: $lastUpdatedWeather)';
  }

  Weather copyWith({
    String? descriptionWeather,
    String? iconWeather,
    double? tempWeather,
    double? tempMinWeather,
    double? tempMaxWeather,
    int? pressureWeather,
    int? humidityWeather,
    double? speedWeather,
    int? degWeather,
    String? nameWeather,
    String? countryWeather,
    DateTime? lastUpdatedWeather,
  }) {
    return Weather(
      descriptionWeather: descriptionWeather ?? this.descriptionWeather,
      iconWeather: iconWeather ?? this.iconWeather,
      tempWeather: tempWeather ?? this.tempWeather,
      tempMinWeather: tempMinWeather ?? this.tempMinWeather,
      tempMaxWeather: tempMaxWeather ?? this.tempMaxWeather,
      pressureWeather: pressureWeather ?? this.pressureWeather,
      humidityWeather: humidityWeather ?? this.humidityWeather,
      speedWeather: speedWeather ?? this.speedWeather,
      degWeather: degWeather ?? this.degWeather,
      nameWeather: nameWeather ?? this.nameWeather,
      countryWeather: countryWeather ?? this.countryWeather,
      lastUpdatedWeather: lastUpdatedWeather ?? this.lastUpdatedWeather,
    );
  }
}
