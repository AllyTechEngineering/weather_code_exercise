import 'package:flutter/foundation.dart';

class ShowWindDirectionClass {
  String showWindDirection(int windDegree) {
    String windDirectionString = 'N';
    // debugPrint('windDegree = $windDegree');
    if (windDegree >= 349 && windDegree <= 11) {
      return windDirectionString = 'N';
    } else if (windDegree >= 12 && windDegree <= 33) {
      return windDirectionString = 'N/NE';
    } else if (windDegree >= 34 && windDegree <= 56) {
      return windDirectionString = 'NE';
    } else if (windDegree >= 57 && windDegree <= 78) {
      return windDirectionString = 'E/NE';
    } else if (windDegree >= 79 && windDegree <= 105) {
      return windDirectionString = 'E';
    } else if (windDegree >= 106 && windDegree <= 123) {
      return windDirectionString = 'E/SE';
    } else if (windDegree >= 124 && windDegree <= 146) {
      return windDirectionString = 'SE';
    } else if (windDegree >= 147 && windDegree <= 168) {
      return windDirectionString = 'S/SE';
    } else if (windDegree >= 169 && windDegree <= 191) {
      return windDirectionString = 'S';
    } else if (windDegree >= 192 && windDegree <= 213) {
      return windDirectionString = 'S/SW';
    } else if (windDegree >= 214 && windDegree <= 236) {
      return windDirectionString = 'SW';
    } else if (windDegree >= 237 && windDegree <= 258) {
      return windDirectionString = 'W/SW';
    } else if (windDegree >= 259 && windDegree <= 281) {
      return windDirectionString = 'W';
    } else if (windDegree >= 282 && windDegree <= 303) {
      return windDirectionString = 'W/NW';
    } else if (windDegree >= 304 && windDegree <= 326) {
      return windDirectionString = 'NW';
    } else if (windDegree >= 327 && windDegree <= 348) {
      return windDirectionString = 'N/NW';
    }
    return windDirectionString;
  }
}
