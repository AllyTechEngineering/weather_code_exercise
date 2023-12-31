// Implement keyword is used to implement an interface by forcing the redefinition of the functions.
class WeatherException implements Exception {
  String message;
  WeatherException([this.message = 'Exception occurred']) {
    message = 'Weather Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
