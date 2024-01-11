// implements is used to signify that the WeatherException class is intended to be a
// subtype of the Exception class. This means that WeatherException
// inherits from Exception and is expected to provide an implementation
// for the methods declared in the Exception class.
class WeatherException implements Exception {
  String message; //instance variable of the WeatherException class

  // constructor with optional message with a default message Weather Exception
  WeatherException([this.message = 'Exception occurred']) {
    message = 'Weather Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
