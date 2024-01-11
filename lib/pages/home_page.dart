import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_stream_bloc/utilities/show_wind_direction.dart';
// import 'package:open_weather_stream_bloc/utilities/calculate_font_size_class.dart';
import 'package:recase/recase.dart';
import '../utilities/constants.dart';
import '../blocs/barrel_blocs.dart';
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
                  return SearchPage(); //_city is not handled by BLoC
                }),
              );
              if (_city != null) {
                // BlocListener, BlocBuilder or BlocConsumer are not needed.
                // This interfaces directly with the WeatherBloc and does not rebuild the UI
                // context.read is the extension method from the provider package to retrieve the instance of the WeatherBloc.
                // The read method is used for reading (or obtaining) a reference to a provider without rebuilding the widget tree.
                // .add is a new FetchWeatherEvent added to WeatherBloc to trigger on<FetchWeatherEvent>(_fetchWeather);
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
    //context.watch<TempSettingsBloc>(): Here, the watch method from the provider package is used to listen for changes to the state of the TempSettingsBloc
    // In BLoC, the state holds the data that represents the current state of the application.
    // .temperatureUnit is the state of the TempSettingsBloc for C or F
    final tempUnit = context.watch<TempSettingsBloc>().state.temperatureUnit;
    return showTemperatureAndWindClass.showTemperatureResults(temperature, tempUnit);
  }

  String showWindSpeed(double windSpeed) {
    final tempUnit = context.watch<TempSettingsBloc>().state.temperatureUnit;
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
        if (state.statusProperty == WeatherStatus.errorStatus) {
          errorDialog(
              context, state.errorProperty.customErrorMessage); //errMsg is in customer_error.dart
        }
      },
      builder: (context, state) {
        if (state.statusProperty == WeatherStatus.initialStatus) {
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

        if (state.statusProperty == WeatherStatus.loadingStatus) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.statusProperty == WeatherStatus.errorStatus &&
            state.weatherProperty.nameWeather == '') {
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
                state.weatherProperty.nameWeather,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Country: ${state.weatherProperty.countryWeather}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Time: ${TimeOfDay.fromDateTime(state.weatherProperty.lastUpdatedWeather).format(context)}',
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
                    'Now: ${showTemperature(state.weatherProperty.tempWeather)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text(
                        'Max: ${showTemperature(state.weatherProperty.tempMaxWeather)}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Min: ${showTemperature(state.weatherProperty.tempMinWeather)}',
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
                    'Humidity: ${state.weatherProperty.humidityWeather} %',
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
                    'Wind Speed: ${showWindSpeed(state.weatherProperty.speedWeather)}',
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
                    'Wind Direction: ${showWindDirectionClass.showWindDirection(state.weatherProperty.degWeather)}',
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
                  showIcon(state.weatherProperty.iconWeather),
                  Expanded(
                    flex: 3,
                    child: formatText(state.weatherProperty.descriptionWeather),
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
