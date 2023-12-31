import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_stream_bloc/utilities/show_wind_direction.dart';
// import 'package:open_weather_stream_bloc/utilities/calculate_font_size_class.dart';
import 'package:recase/recase.dart';
import '../utilities/constants.dart';
import '../blocs/blocs.dart';
import '../utilities/show_temperature_and_wind.dart';
import '../widgets/error_dialog.dart';
import 'search_page.dart';
import 'settings_page.dart';
// import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ShowWindDirectionClass showWindDirectionClass = ShowWindDirectionClass();
  final ShowTemperatureAndWindClass showTemperatureAndWindClass = ShowTemperatureAndWindClass();
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Report',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }),
              );
              if (_city != null) {
                context.read<WeatherBloc>().add(FetchWeatherEvent(city: _city!));
              }
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/weather_background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: _showWeather(),
    );
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;
    return showTemperatureAndWindClass.showTemperatureResults(temperature, tempUnit);
  }

  String showWindSpeed(double windSpeed) {
    final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;
    return showTemperatureAndWindClass.showWindSpeedResults(windSpeed, tempUnit);
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: kShowIconWidth,
      height: kShowIconHeight,
    );
  }

  Widget formatText(String description) {
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: Theme.of(context).textTheme.displayLarge,
      textAlign: TextAlign.center,
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 1.0,
                    image: AssetImage('assets/images/sunny_weather.png'),
                    fit: BoxFit.cover)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: kIconSearchSize,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () async {
                      _city = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SearchPage();
                        }),
                      );
                      // This is where the city from the search page goes
                      if (_city != null) {
                        context.read<WeatherBloc>().add(FetchWeatherEvent(city: _city!));
                      }
                    },
                  ),
                  Text(
                    'Click For Weather',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return Center(
            child: Text(
              'Select a city',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1.0,
                image: AssetImage('assets/images/sunny_weather.png'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                state.weather.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Country: ${state.weather.country}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Time: ${TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Divider(
                thickness: 2.0,
                indent: 20.0,
                endIndent: 20.0,
                height: 20.0,
                color: Colors.black,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Now: ${showTemperature(state.weather.temp)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text(
                        'Max: ${showTemperature(state.weather.tempMax)}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Min: ${showTemperature(state.weather.tempMin)}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Divider(
                thickness: 2.0,
                indent: 20.0,
                endIndent: 20.0,
                height: 20.0,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Humidity: ${state.weather.humidity} %',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wind Speed: ${showWindSpeed(state.weather.speed)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wind Direction: ${showWindDirectionClass.showWindDirection(state.weather.deg)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Divider(
                thickness: 2.0,
                indent: 20.0,
                endIndent: 20.0,
                height: 20.0,
                color: Colors.black,
              ),
              // const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  showIcon(state.weather.icon),
                  Expanded(
                    flex: 3,
                    child: formatText(state.weather.description),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
