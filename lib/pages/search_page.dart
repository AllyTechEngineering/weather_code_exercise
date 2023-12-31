import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_weather_stream_bloc/repositories/weather_repository.dart';
import '../utilities/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _city;
  String? _currentAddress;
  Position? _currentPosition;
  // dynamic _positionResults;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: kIconThemeIconSize,
            color: Color(kIconThemeColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Search...',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/weather_background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1.0,
                image: AssetImage('assets/images/sunny_weather.png'),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 60.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  // style: const TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    fillColor: Colors.blue,
                    labelText: 'City Name',
                    labelStyle: Theme.of(context).textTheme.displayLarge,
                    hintText: 'Must be more than 2 characters',
                    // hintStyle: Theme.of(context).textTheme.displaySmall,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 10.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (String? input) {
                    if (input == null || input.trim().length < 2) {
                      return 'City name: at least 2 characters';
                    }
                    return null;
                  },
                  onSaved: (String? input) {
                    _city = input;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                //          fixedSize: Size(250.0, 75.0),
                width: 300.0,
                height: 75.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFECD6),
                      Color(0xFF4CB9E7),
                    ],
                    stops: [0.0, 0.9],
                  ),
                  // color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    "Check Any City Weather",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //          fixedSize: Size(250.0, 75.0),
                  width: 300.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFECD6),
                        Color(0xFF4CB9E7),
                      ],
                      stops: [0.0, 0.9],
                    ),
                    // color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ElevatedButton(
                    onPressed: getCurrentLatAndLon,
                    child: Text(
                      "Check Local Weather",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      Navigator.pop(context, _city!.trim());
    }
  }

  void getCurrentLatAndLon() {
    _handleLocationPermission();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    // new code to stop from asking permission over and over again
    // permission != LocationPermission.always
    // if (permission != LocationPermission.always) {
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    // }

    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // debugPrint('position = ${position.longitude}');
      // debugPrint('position = ${position.latitude}');
      // _positionResults = position;
      double _lat = position.latitude;
      double _lon = position.longitude;
      //_latAndLonList[0] = _lat;
      // _latAndLonList[0] = _lon;
      //Navigator.pop(context, position);
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    // debugPrint('In Geocoder which has request limits');
    await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.locality}';
        _city = place.locality;
        Navigator.pop(context, _city!.trim());
        debugPrint('This is the current address: $_currentAddress');
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
