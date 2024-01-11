import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String nameProperty;
  final double latProperty;
  final double lonProperty;
  final String countryProperty;
  DirectGeocoding({
    required this.nameProperty,
    required this.latProperty,
    required this.lonProperty,
    required this.countryProperty,
  });

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(
      nameProperty: data['name'],
      latProperty: data['lat'],
      lonProperty: data['lon'],
      countryProperty: data['country'],
    );
  }

  @override
  List<Object> get props => [nameProperty, latProperty, lonProperty, countryProperty];

  @override
  String toString() {
    return 'DirectGeocoding(name: $nameProperty, lat: $latProperty, lon: $lonProperty, country: $countryProperty)';
  }
}
