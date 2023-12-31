import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final double temp; //checked
  final double tempMin;
  final double tempMax;
  final int pressure; //checked
  final int humidity; //checked
  final double speed;
  final int deg;
  final String name;
  final String country;
  final DateTime lastUpdated;
  Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.speed,
    required this.deg,
    required this.name,
    required this.country,
    required this.lastUpdated,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];

    return Weather(
      description: weather['description'],
      icon: weather['icon'],
      temp: main['temp'],
      tempMin: main['temp_min'],
      tempMax: main['temp_max'],
      pressure: main['pressure'],
      humidity: main['humidity'],
      speed: wind['speed'],
      deg: wind['deg'],
      name: '',
      country: '',
      lastUpdated: DateTime.now(),
    );
  }

  factory Weather.initial() => Weather(
        description: '',
        icon: '',
        temp: 100.0,
        tempMin: 100.0,
        tempMax: 100.0,
        pressure: 0,
        humidity: 0,
        speed: 0.0,
        deg: 0,
        name: '',
        country: '',
        lastUpdated: DateTime(1970),
      );

  @override
  List<Object> get props {
    return [
      description,
      icon,
      temp,
      tempMin,
      tempMax,
      pressure,
      humidity,
      speed,
      deg,
      name,
      country,
      lastUpdated,
    ];
  }

  @override
  String toString() {
    return 'Weather(description: $description, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity,speed: $speed, deg: $deg, name: $name, country: $country, lastUpdated: $lastUpdated)';
  }

  Weather copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    double? speed,
    int? deg,
    String? name,
    String? country,
    DateTime? lastUpdated,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
