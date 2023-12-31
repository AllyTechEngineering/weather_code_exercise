# open_weather_stream_bloc
## A weather app with current location and city search weather results
### Developer: Bob Taylor bob.taylor.mscs.mba@gmail.com

This project uses BLoC state management with a repository.
In this version StreamSubscription will be used.

- StreamSubscription
    - Pros
        - Organized, structured and easy to read and maintain.
        - TBD
    - Cons
        - It may get cluttered really fast and hard to scale on large apps.
        - Most remember to close StreamSubscriptions to avoid memory leaks. 
- BlocListener
    - Pros
        - Takes care of SteamSubscriptions internally.
        - Automatically closes SteamSubscriptions.
    - Cons
        - UI will get cluttered if many BlocListeners are needed.
        TBD

## BLoC Blocs Used
- TempSettingsBloc used to change for C to F state transition.
- _ThemeBloc handles the dart to light state transition._
  **- Did not implement ThemeBlock for this code exercise**
- WeatherBloc works with WeatherRepository to handle data from API call to openWeather.

## BLoC Repository Used
- WeatherRepository

##  Flutter BLoC Used
- RepositoryProvider for dependency injection.
- MultiBlocProvider to avoid nesting BlocProviders
- BlocProvider<WeatherBloc>
    - context.read<WeatherRepository> used to provide WeatherRepository to WeatherCubit.
- BlocProvider<TempSettingsBloc>
- BlocProvider<ThemeBloc>
- BlocListener<WeatherBloc, WeatherState> was used to pass the state changes of the temperature to context.read<ThemeBloc> .

## Models Used
openWeather has deprecated using City and Country for weather look up and need lat and lon instead.
- Weather used to model the weather data for the UI.
- DirectGeocoding used to model the data for the lat and lon call to get city data.
- CustomError used to model the error messages.
- openWeather free API may have service issues and that will present as an error dialog alert.
- During testing, searching for Mountain View or Flagstaff would occasionally have an error. Was unable to track down the cause.

## Services Used
- http_error_handler.dart
- WeatherApiServices (weather_api_services.dart)

## Other
- Used the flutter_dotenv package to hide the API key in a .env file and used gitignore to ensure the file was not made public on GitHub.

## Packages Used
- geocoding:
    - A Flutter Geocoding plugin which provides easy geocoding and reverse-geocoding features.
    - Note: uses the free Geocoding services provided by the iOS and Android platforms which has limitations. 
- geolocator:
    - A Flutter geolocation plugin which provides easy access to platform specific location services
- equatable: 
    - A Dart package that helps to implement value based equality without needing to explicitly override == and hashCode.
- flutter_bloc: 
    - Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.
- flutter_dotenv: 
    - Easily configure any flutter application with global variables using a `.env` file.
- http: 
    - A composable, multi-platform, Future-based API for HTTP requests.
- recase: 
    - Changes the case of the input text to the desire case convention.

## To run the project:
- in VS Code use debug and it will run the launch.json for debug, profile or release
- in Android Studio select the emulator and use Run or Debug 'main.dart'
- apk files are in weather_code_exercise/build/app/outputs/flutter-apk/


## Know issues and TODO:
- This project was original for searching for city weather. I refactored to add the local weather as per the requirements. 
- TODO: The UI and state management need to be changed to show local weather first and optionally allow for other city searches.
- Android Studio - Android emulators can take up to 20+ seconds to load a custom location weather report. Was unable to determine why this is happening.
- TODO: Need to add a status indicator to the user that the system is loading weather data.
- iOS devices did not have this issue of long delays.
- My Apple developer account is in the process of changing from personal developer to a corporate developer account using my personally AllyTech LLC and I am unable to sign the iOS app and therefore was unable to run this on a physical device.
- I do not have any Android physical devices so the app was not run on a physical device.