import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_stream_bloc/utilities/show_wind_direction.dart';

void main() {
  test('Check wind degree decimal to string', () {
    // Assert
    expect(ShowWindDirectionClass().showWindDirection(349), 'N');
    expect(ShowWindDirectionClass().showWindDirection(11), 'N');
    expect(ShowWindDirectionClass().showWindDirection(12), 'N/NE');
    expect(ShowWindDirectionClass().showWindDirection(33), 'N/NE');
    expect(ShowWindDirectionClass().showWindDirection(34), 'NE');
    expect(ShowWindDirectionClass().showWindDirection(56), 'NE');
    expect(ShowWindDirectionClass().showWindDirection(57), 'E/NE');
    expect(ShowWindDirectionClass().showWindDirection(78), 'E/NE');
    expect(ShowWindDirectionClass().showWindDirection(79), 'E');
    expect(ShowWindDirectionClass().showWindDirection(105), 'E');
    expect(ShowWindDirectionClass().showWindDirection(106), 'E/SE');
    expect(ShowWindDirectionClass().showWindDirection(123), 'E/SE');
    expect(ShowWindDirectionClass().showWindDirection(124), 'SE');
    expect(ShowWindDirectionClass().showWindDirection(146), 'SE');
    expect(ShowWindDirectionClass().showWindDirection(147), 'S/SE');
    expect(ShowWindDirectionClass().showWindDirection(168), 'S/SE');
    expect(ShowWindDirectionClass().showWindDirection(169), 'S');
    expect(ShowWindDirectionClass().showWindDirection(191), 'S');
    expect(ShowWindDirectionClass().showWindDirection(192), 'S/SW');
    expect(ShowWindDirectionClass().showWindDirection(213), 'S/SW');
    expect(ShowWindDirectionClass().showWindDirection(214), 'SW');
    expect(ShowWindDirectionClass().showWindDirection(236), 'SW');
    expect(ShowWindDirectionClass().showWindDirection(237), 'W/SW');
    expect(ShowWindDirectionClass().showWindDirection(258), 'W/SW');
    expect(ShowWindDirectionClass().showWindDirection(259), 'W');
    expect(ShowWindDirectionClass().showWindDirection(281), 'W');
    expect(ShowWindDirectionClass().showWindDirection(282), 'W/NW');
    expect(ShowWindDirectionClass().showWindDirection(303), 'W/NW');
    expect(ShowWindDirectionClass().showWindDirection(304), 'NW');
    expect(ShowWindDirectionClass().showWindDirection(326), 'NW');
    expect(ShowWindDirectionClass().showWindDirection(327), 'N/NW');
    expect(ShowWindDirectionClass().showWindDirection(348), 'N/NW');
  });
}
