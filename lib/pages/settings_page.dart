import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/barrel_blocs.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 1.0,
                  image: AssetImage('assets/images/weather_background.png'),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1.0,
                image: AssetImage('assets/images/sunny_weather.png'),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2.0, color: Colors.black)),
                child: ListTile(
                  title: Text(
                    'Imperial - Metric',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  subtitle: Text(
                    'Default: Metric',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  trailing: Switch(
//The value parameter determines whether the switch is currently in the "on" or "off" state. It is set based on the current state of the TempSettingsBloc. The context.watch method is used to subscribe to changes in the TempSettingsBloc's state, and context.watch<TempSettingsBloc>().state.temperatureUnit retrieves the current temperature unit from the bloc's state. The comparison checks if the current temperature unit is TemperatureUnit.celsiusStatus.
                    value: context.watch<TempSettingsBloc>().state.temperatureUnit ==
                        TemperatureUnit.celsiusStatus,
                    onChanged: (_) {
                      context.read<TempSettingsBloc>().add(ToggleTempUnitEvent());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
